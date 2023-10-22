import "list"

#even: [for i, x in [1] * 1000 let v = i + 1 if mod(v, 2) == 0 {v}]

#factored: [for n in #even
           {[n] + [for i, x in div(n, 2) * [1] let v = i + 1 if mod(n, v) == 0 {v}]}]

perfect: [for f in #factored
          let n = f[0]
          if list.Sum(f) == n * 2
          {n}]
