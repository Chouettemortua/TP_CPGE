let f () =
  let t = Sys.argv in
  let n = Array.length t in
  let res = ref 0 in
  for i = 1 to n-1 do
    res := !res+(int_of_string t.(i))
  done;
  !res
;;

print_int(f());;
print_newline();;