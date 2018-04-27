structure RegAllocUtil = 
struct
	structure T = Graph.Table
	  (*Makes a hashset of the values in a list of nodes*)
  fun makeHS([], hs) = hs
    | makeHS(i :: l, hs) =
      let 
        val hs' = T.enter(hs, i, ())
      in 
        makeHS(l, hs')
      end
  fun contains(elm, [], eq) = false
    | contains(elm, l :: rest, eq) =
      (eq (elm, l)) orelse contains(elm, rest, eq)

  fun moveEq((a1, a2), (b1, b2)) = 
    (Graph.eq(a1, b1) andalso Graph.eq(a2, b2))
  (*add all of the items in l not in the hashset hs 
    to acc and then return acc*)
  fun helpUnionSub([], acc, hs) = acc
    | helpUnionSub(item :: l, acc, hs) = 
        (case T.look(hs, item) 
          of SOME() => helpUnionSub(l, acc, hs)
           | NONE =>  helpUnionSub(l, item :: acc, hs))

  (*add all of the items in l that are in the hashset hs 
  to acc and then return acc*)
  fun helpIntersect([], acc, hs) = acc
    | helpIntersect(item :: l, acc, hs) = 
        (case T.look(hs, item) 
          of SOME() => helpIntersect(l, item :: acc, hs)
           | NONE =>  helpIntersect(l, acc, hs))

(*add all of the items in l and not in l2
    to acc and then return acc*)
  fun helpmUnionSub([], acc, l2, eq) = acc
    | helpmUnionSub(item :: l, acc, l2, eq) = 
        if contains(item, l2, eq) 
        then  helpmUnionSub(l, acc, l2, eq)
        else  helpmUnionSub(l, item :: acc, l2, eq)

  (*add all of the items in l and in l2
  to acc and then return acc*)
  fun helpmIntersect([], acc, l2, eq) = acc
    | helpmIntersect(item :: l, acc, l2, eq) = 
        if contains(item, l2, eq) 
        then  helpmIntersect(l, item :: acc, l2, eq)
        else  helpmIntersect(l, acc, l2, eq)


  (*returns the union of two dlists.*)
  fun union(l1, l2)  = 
      helpUnionSub(l1, l2, makeHS(l2, T.empty))

  (*returns the contents of dlist l1 - the contents of l2*)
  fun sub(l1, l2) =
      helpUnionSub(l1, [], makeHS(l2, T.empty))

  (*returns the intersect of dlists l1 and l2*)
  fun intersect(l1, l2) =
  		helpIntersect(l1, [], makeHS(l2, T.empty))


	(*returns the union of two (node * node) dlists.*)
  fun munion(l1, l2, eq)  = 
      helpmUnionSub(l1, l2, l2, eq)

  (*returns the contents of (node * node) dlist l1 - the contents of l2*)
  fun msub(l1, l2, eq) =
      helpmUnionSub(l1, [], l2, eq)

  (*returns the intersect of (node * node) dlists l1 and l2*)
  fun mintersect(l1, l2, eq) =
  		helpmIntersect(l1, [], l2, eq)

  (*returns the value associated with the node in the table
    This assumes that the node is required to be in the table*)
  fun getFrom(node, table) = 
      case T.look(table, node)
        of NONE => 
        (print(Graph.nodename(node));
        ErrorMsg.impossible 
                    "node  not in table but should be")
         | SOME(v) => v


  (*returns the value associated with the temp in the table
    This assumes that the temp is required to be in the table*)
  fun getFromTemp(node, table) = 
      case Temp.Table.look(table, node)
        of NONE => ErrorMsg.impossible 
                    "node not in table but should be"
         | SOME(v) => v

end