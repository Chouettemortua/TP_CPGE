(*_____Types_____*)
type 'a mot = 'a list

(* expressions régulières *)
type 'a exp_reg =
	Vide (* Langage vide *)
	| Symbole of 'a (* Lettre *)
	| Union of ('a exp_reg * 'a exp_reg)
	| Concat of ('a exp_reg * 'a exp_reg)
	| Etoile of ('a exp_reg)


(*_____Affichage_____*)

(* affiche un mot *)
let affiche_mot (u : 'a mot) (print : 'a -> unit) : unit =
    List.iter print u

(* affiche une expression régulière d'un type quelconque *)
let rec affiche_exp (e : 'a exp_reg) (print : 'a -> unit) : unit =
	match e with
	| Vide -> Printf.printf "V"
	| Symbole a -> print a
	| Union(e1,e2) -> affiche_exp e1 print ; Printf.printf " | " ; affiche_exp e2 print
	| Concat(e1,e2) -> 
		begin
		match e1,e2 with
		| Union(_),Union(_) -> Printf.printf "(" ; affiche_exp e1 print ; Printf.printf ")(" ; affiche_exp e2 print ; Printf.printf ")"
		| Union(_),_ -> Printf.printf "(" ; affiche_exp e1 print ; Printf.printf ")" ; affiche_exp e2 print
		| _,Union(_) -> affiche_exp e1 print ; Printf.printf "(" ; affiche_exp e2 print ; Printf.printf ")"
		| _ -> affiche_exp e1 print ; affiche_exp e2 print
		end
	| Etoile(e1) -> 
		begin
		match e1 with
		| Union(_) -> Printf.printf "(" ; affiche_exp e1 print ; Printf.printf ")*"
		| Concat(_) -> Printf.printf "(" ; affiche_exp e1 print ; Printf.printf ")*"
		| _ -> affiche_exp e1 print ; Printf.printf "*"
		end

(* affiche un mot sur le type char *)
let affiche_mot_char (u : char mot) = affiche_mot print_char

(* affiche une expression régulière sur le type char *)
let affiche_exp_char (e : char exp_reg) = affiche_exp e print_char

(*_____Fonction préliminaire_____*)

(* teste si L(e) contient le mot vide *)
let rec genere_epsilon (e : 'a exp_reg) : bool =	
	match e with
	| Vide -> false
	| Symbole a -> false
	| Union(e1,e2) -> (genere_epsilon e1) || (genere_epsilon e2)
	| Concat(e1,e2) -> (genere_epsilon e1) && (genere_epsilon e2)
	| Etoile(e1) -> true

