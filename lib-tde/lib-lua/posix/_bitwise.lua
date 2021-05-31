

return {
   band = function(a, ...)
      for _, v in next, {...} do
        a = a & v
      end
      return a
   end,

   bor = function(a, ...)
      for _, v in next, {...} do
        a = a | v
      end
      return a
   end,

   bnot = function(a) return ~a end,
}
