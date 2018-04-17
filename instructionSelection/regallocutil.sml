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

  (*add all of the items in l not in the hashset hs 
    to acc and then return acc*)
  fun helpUnionSub([], acc, hs) = acc
    | helpUnionSub(item :: l, acc, hs) = 
        (case T.look(hs, item) 
          of SOME() => helpUnionSub(l, acc, hs)
           | NONE =>  helpUnionSub(l, item :: acc, hs))

  (*add all of the items in l not in the hashset hs 
  to acc and then return acc*)
  fun helpIntersect([], acc, hs) = acc
    | helpIntersect(item :: l, acc, hs) = 
        (case T.look(hs, item) 
          of SOME() => helpIntersect(l, item :: acc, hs)
           | NONE =>  helpIntersect(l, acc, hs))


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
  fun munion(l1, l2)  = 
      helpUnionSub(l1, l2, makeHS(l2, T.empty))

  (*returns the contents of (node * node) dlist l1 - the contents of l2*)
  fun msub(l1, l2) =
      helpUnionSub(l1, [], makeHS(l2, T.empty))

  (*returns the intersect of (node * node) dlists l1 and l2*)
  fun mintersect(l1, l2) =
  		helpIntersect(l1, [], makeHS(l2, T.empty))

end