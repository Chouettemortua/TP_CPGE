let affiche_fichier nom_fichier =
  let fichier_in = open_in nom_fichier in
  let verif = ref 1 in
  while !verif=1 do
    try begin
      let ligne = input_line fichier_in in
      print_endline ligne;
    end with End_of_file ->
      verif := 0;
      close_in fichier_in;
  done;
;;

let main () =
  affiche_fichier("quine.ml");
;;

main()