let count_line filename =
  let count = ref 0 in
  let f = open_in filename in
  let rec loop() =
    try
      let _ = input_line f in
      count := !count+1;
      loop()
    with
    | End_of_file -> () in
  loop();
  close_in f;
  !count
;;

print_endline (string_of_int(count_line "text.txt"));;