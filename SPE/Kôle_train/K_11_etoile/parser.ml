exception Stop of int

let read_next_string (s : string) (i : int) : (string * int) =
	let n = String.length s in
	if i >= n then ("",i+1)
	else if s.[i] = '\n' then ("\n",i+1)
	else if s.[i] = ' ' then (" ",i+1)
	else if s.[i] = ',' then (",",i+1)
	else if s.[i] = '.' then (".",i+1)
	else if s.[i] = ';' then (";",i+1)
	else if s.[i] = ':' then (":",i+1)
	else if s.[i] = '?' then ("?",i+1)
	else if s.[i] = '!' then ("!",i+1)
	else if s.[i] = '+' then ("+",i+1)
	else if s.[i] = '-' then ("-",i+1)
	else if s.[i] = '\"' then ("\"",i+1)
	else if s.[i] = '(' then ("(",i+1)
	else if s.[i] = ')' then (")",i+1)
	else if s.[i] = '\'' then ("\'",i+1)
	else
		try
			for j = i to n - 1 do
				if (Char.code (s.[j]) >= 48 && Char.code (s.[j]) <= 57)  (* chiffres *)
					|| (Char.code (s.[j]) >= 97 && Char.code (s.[j]) <= 122) (* minuscules *)
					|| (Char.code (s.[j]) >= 65 && Char.code (s.[j]) <= 90) (* majuscules *)
					 then ()
				else raise (Stop j)
			done ;
			(String.sub s i (n-i), n)
		with
		| Stop j ->  (String.sub s i (j-i), j)



let cpt = ref 0 


(* renvoie un tableau de string représentant le contenu du fichier (sans les espaces) *)
let parse (filename : string) (debug_mode : bool) =

	(* ouverture du fichier de sortie pour debuguer *)
  let debug = ref stdout in
	if debug_mode then debug :=	open_out "debug";

	(* ouverture du fichier à lire *)
	let oc = open_in filename in
	
	(* affichage de debug *)
	if debug_mode then Printf.fprintf !debug "On a ouvert le fichier \"%s\".\n" filename ;

	(* fonction auxiliaire qui lit nb lignes du fichier ouvert *)
	(* stock la liste des listes de mots lus à chaque ligne *)
	let rec aux_read (data : string list list) (nb : int) =
		try 
			let s = input_line oc in 

			(* affichage de debug *)
			if debug_mode then Printf.fprintf !debug "On a lu la ligne \"%s\"%! de longueur %d. Son dernier caractère est s[%d] = %c.%!" s (String.length s) (((String.length s)-1)) s.[(String.length s)-1];

			let rec aux_data (i : int) (data_list : string list) =
				if i >= String.length s then
					data_list
				else 
					begin
					
					(* on lit le prochain lexême k, et k est le prochain indice où l'on pourra commener à lire *)
					let (x,k) = read_next_string s i in 
					
					(* affichage de debug *)
					if debug_mode then Printf.fprintf !debug "On a lu \"%s\" et on a atteint k = %d.\n%!" x k ;

					(* si fin de ligne, on arrête ; sinon, on continue *)
					if k = (String.length s)-1 then " "::data_list else aux_data k (x::data_list)
					(*
					let new_data_list = if x = "" then data_list else (x::data_list) in
					if k = (String.length s)-1 then new_data_list else aux_data k new_data_list *)
					end
			in 
					let x = aux_data 0 [] in
					(* Array.of_list ((List.rev (List.flatten (x::data)))) *) aux_read (x::data) (nb+1)
		with
		| End_of_file -> close_in oc ; Array.of_list ((List.rev (List.flatten data)))
	
	in 
	let res = aux_read [] 1 in 

	(* affichage de debug *)
	if debug_mode then begin Printf.printf "Fichier \"%s\" analysé.\n%!" filename ; close_out !debug end ;

	res






