(*_____Types_____*)
type 'a mot = 'a list ;;

(* expressions régulières *)
type 'a exp_reg =
	Vide (* Langage vide *)
	| Symbole of 'a (* Lettre *)
	| Union of ('a exp_reg * 'a exp_reg)
	| Concat of ('a exp_reg * 'a exp_reg)
	| Etoile of ('a exp_reg)
;;


(*_____Affichage_____*)

(* affiche un mot *)
let affiche_mot (u : 'a mot) (print : 'a -> unit) : unit =
    List.iter print u
;;

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
;;

(* affiche un mot sur le type char *)
let affiche_mot_char (u : char mot) = affiche_mot u print_char;;

(* affiche une expression régulière sur le type char *)
let affiche_exp_char (e : char exp_reg) = affiche_exp e print_char;;

(*_____Fonction préliminaire_____*)

(* teste si L(e) contient le mot vide *)
(*
	Q1) Complexité en O(t(e)), ou t(e) est la taille de l'expression e.
			Preuve de correction de genere_epsilon
				- Cas de base :
					. e = Vide : L(e) = {} donc L(e) ne contient pas le mot vide -> retourne false
					. e = Symbole a : L(e) = {a} donc L(e) ne contient pas le mot vide -> retourne false
				- Cas inductif :
					. e = Union(e1,e2) : L(e) = L(e1) ∪ L(e2)
						. Si L(e1) contient le mot vide, alors L(e) contient le mot vide -> retourne true
						. Si L(e2) contient le mot vide, alors L(e) contient le mot vide -> retourne true
						. Sinon, L(e) ne contient pas le mot vide -> retourne false
					. e = Concat(e1,e2) : L(e) = L(e1)L(e2)
						. Si L(e1) contient le mot vide et L(e2) contient le mot vide, alors L(e) contient le mot vide -> retourne true
						. Sinon, L(e) ne contient pas le mot vide -> retourne false
					. e = Etoile(e1) : L(e) = L(e1)*
						. L(e) contient toujours le mot vide -> retourne true
				Donc par induction, la fonction genere_epsilon est correcte.
*)
let rec genere_epsilon (e : 'a exp_reg) : bool =	
	match e with
	| Vide -> false
	| Symbole a -> false
	| Union(e1,e2) -> (genere_epsilon e1) || (genere_epsilon e2)
	| Concat(e1,e2) -> (genere_epsilon e1) && (genere_epsilon e2)
	| Etoile(e1) -> true
;;

(*Test si L(e) = ∅*)
(*
	Q2) et Q3) Complexcité en O(t(e)), où t(e) est la taille de l'expression e.
*)
let rec est_vide (e : 'a exp_reg) : bool =
	match e with
	| Vide -> true
	| Symbole a -> false
	| Union(e1,e2) -> (est_vide e1) && (est_vide e2)
	| Concat(e1,e2) -> (est_vide e1) || (est_vide e2)
	| Etoile(e1) -> false
;;

(*Q4)*)
(*Test si le langage générer par L(e) est le langage réduit au mot vide*)
let rec langage_epsilon (e : 'a exp_reg) : bool =
	match e with
	| Vide -> false
	| Symbole a -> false
	| Union(e1,e2) -> (langage_epsilon e1) && (est_vide e2) || (langage_epsilon e2) && (est_vide e1) || (langage_epsilon e1) && (langage_epsilon e2)
	| Concat(e1,e2) -> (langage_epsilon e1) && (langage_epsilon e2)
	| Etoile(e1) -> langage_epsilon e1 || est_vide e1
;;

(*  
	Q5)
	u^-1L = { v | uv ∈ L }, u ∈ Σ*, L ⊆ Σ*
	Pour que u ∈ L, il faut u^-1L contienne le mot vide.
	Car si le mot vide est dans u^-1L, on Concat(u, mot vide) = u, donc u ∈ L.
*)

(*
	Q6)
	Soit e0 = ab*a, 
	Voici un expression régulière pour L1 = a^-1L(e0) : "bbbba", "a"
	Voici une expression régulière pour L2 = b^-1L1 : "bbbba"
	Voici une expression régulière pour L3 = a^-1L2 : "mot vide"
*)

(*
	Q7) (faire par implication)
	u = av avec v ∈ Σ* 
	donc u^-1L(e) = {w ∈ Σ* | avw ∈ L} 
	Or avw = a(vw) 
	Or v^-1(a^-1L) = {w | vw ∈ a^-1L} ce sont les mots qui s'écrivent avw dans L car a^-1l sont les mots qui s'écrivent aw dans L
	Donc u^-1L = v^-1(a^-1L)
*)

(*
	Q8) 
	e0 = ab*a
	Donc a^-1L(e0) = L1 contient ba
	Donc b^-1L1 = L2 contient a
	Donc a^-1L2 = L3 contient mot vide
	et le mot vide ∈ a^-1(b^-1(a^-1L(e0)))) or aba est construit par Concat(a, Concat(b,a)) 
	donc le mot vide ∈ (a^-1(b^-1(a^-1L(e0)))) montre que aba ∈ L(e0)
*)

(*Q9)*)
(*Calcule le langage a^-1L(e)*)
let rec derivee (e : 'a exp_reg) (a : 'a) : 'a exp_reg =
	match e with
	| Vide -> Vide
	| Symbole b -> if a = b then Etoile(Vide) else Vide
	| Union(e1,e2) -> Union(derivee e1 a, derivee e2 a)
	| Concat(e1,e2) -> 
		if genere_epsilon e1 then
			Union(Concat(derivee e1 a, e2), derivee e2 a)
		else
			Concat(derivee e1 a, e2)
	| Etoile(e1) -> Concat(derivee e1 a, Etoile(e1))
;;

(*
	Q10)
	Comme u = av -> u^-1L = v^-1(a^-1L)
	On procède de cette manière pour chaque lettre de u
	et obtient ainsi u^-1L = (u_n^-1(...(u_2^-1(u_1^-1L)...)))
*)

(*Q11)*)
let rec accepte_simple (e : 'a exp_reg) (u : 'a mot) : bool =
	(*visual debug and perf*)
	(*affiche_exp_char e ;
	Printf.printf "\n" ;*)
	match u with
	| [] -> genere_epsilon e
	| a::v -> accepte_simple (derivee e a) v
;;


(*_____Tests_____*)
let test = Concat((Union (Symbole 'a', (Etoile (Symbole 'a')))), (Symbole 'b'));;

(*accepte_simple test ['a';'a';'b'];;*)
(*accepte_simple test ['a';'a';'a'];;*)
(*accepte_simple test ['b'];;*)
(*accepte_simple test ['a';'b'];;*)

(*
	Q12)
	La taille des expressions régulière calculer pour les expressions régulières de la forme a^n b;
	et pour les expressions régulières de la forme ( a| a* )b;
	dépend de la taille du mot u et de la taille de l'expression e par la dérivée ou les génere_epsilon.
	Le mot u est parcouru une seule fois, et pour chaque lettre du mot u,
	et le calcul de la dérivée et de genere_epsilon.
	Mais les exprésion générées par la dérivée et sont de plus en plus grande selon le nb de dérivées faites.,
	il sont tous les deux en O(t(e)) où t(e) est la taille de l'expression e.
	On s'attend donc à une complexité en O(e^n) où n est la taille du mot u.
*)

(* Q13) *)
(* Simplifie une expression régulière en supprimant les parties inutiles *)
let rec simplifie (e : 'a exp_reg) : 'a exp_reg =
	match e with
	| Vide -> Vide
	| Symbole a -> Symbole a
	| Union(e1,e2) -> 
		if e1 = e2 then simplifie e1
		else if est_vide e1 && est_vide e2 then Vide
		else if est_vide e1 then simplifie e2
		else if est_vide e2 then simplifie e1
		else if langage_epsilon e1 && genere_epsilon e2 then simplifie e2
		else if langage_epsilon e2 && genere_epsilon e1 then simplifie e1
		else Union(simplifie e1, simplifie e2)
	| Concat(e1,e2) -> 
		if est_vide e1 && est_vide e2 then Vide
		else if est_vide e1 || langage_epsilon e1 then simplifie e2
		else if est_vide e2 || langage_epsilon e2 then simplifie e1
		else Concat(simplifie e1, simplifie e2)
	| Etoile(e1) -> 
		if est_vide e1 then Etoile(Vide)
		else Etoile(simplifie e1)
;;

(* Q14) *)
(* accepte utilisant simplifie (plus efficace ?) *)
let rec accepte_mieux (e : 'a exp_reg) (u : 'a mot) : bool =
	(*visual debug and perf*)
	(*affiche_exp_char e ;
	Printf.printf "\n" ;*)
	match u with
	| [] -> genere_epsilon e
	| a::v -> accepte_mieux (simplifie(derivee e a)) v
;;

(* Q15) *)
(* Les même dériver sont calculer plusieur fois pour par exemple (a|a* )b* donc on veut la calculer une seul fois dans ce cas*)
(* faut mettre en place un mémoisation avec un hash ! (pas fait) *)
let accepte (e : 'a exp_reg) (u : 'a mot) : bool =
	let rec aux (e : 'a exp_reg) (u : 'a mot) (mem: int ) : bool =
		(*visual debug and perf*)
		affiche_exp_char e ;
	Printf.printf "\n" ;
		match u with
		| [] -> genere_epsilon e
		| a::v -> 
			aux (simplifie(derivee e a)) v mem
	in
	aux e u 1
;;