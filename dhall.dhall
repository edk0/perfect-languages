let sum = \(l : List Natural) ->
	List/fold Natural l Natural (
		\(x : Natural) -> \(s : Natural) ->
		x + s
	) 0
let equals = \(a : Natural) -> \(b: Natural) ->
	let da = Natural/subtract b a
	let db = Natural/subtract a b
	in Natural/isZero (da + db)
let filter = \(t : Type) -> \(p : t -> Bool) -> \(l : List t) ->
	List/fold t l (List t) (
		\(x : t) -> \(xs : List t) ->
			xs # (if p x then [x] else [] : List t)
	) ([] : List t)
let divides = \(b : Natural) -> \(a : Natural) ->
	True != Natural/isZero (Natural/fold a Natural (
		\(x : Natural) ->
			let d = Natural/subtract b x
			let e = Natural/subtract x b
			in if Natural/isZero (d + e) then x else d
	) a)
let enumerate = \(n : Natural) ->
	let r = Natural/fold n {n : Natural, l : List Natural} (
		\(x : {n : Natural, l : List Natural}) ->
			{n = (x.n + 1), l = x.l # [x.n]}
	) ({n = 1, l = [] : List Natural})
	in r.l
let factor = \(n : Natural) -> filter Natural (\(x : Natural) -> divides x n) (enumerate n)
let perfect = \(n : Natural) ->
	equals (sum (factor n)) (n * 2)
in filter Natural perfect (enumerate 100)
