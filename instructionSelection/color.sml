structure Color : COLOR = 
struct
	structure Frame = MipsFrame

	type allocation = Frame.register Temp.Table.table

	fun color({interference: Liveness.igraph,
			   		 initial: allocation,
						 spillCost: Graph.node -> int,
						 registers: Frame.register list }) : 
						 	allocation * Temp.temp list = ()

end