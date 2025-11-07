(* Yamada Tomohiro *)
(* 2ème année, SPE *)
(* 2024/2025 *)

(*_____Types_____*)

(* expressions régulières *)
type exp_reg =
	Vide
	| Epsilon
	| Symbole of char
	| Union of (exp_reg * exp_reg)
	| Concat of (exp_reg * exp_reg)
	| Etoile of (exp_reg)
;;
(* on notera |e| la taille d'une expression régulière *)

(* automates *)
type automate = {
	nb : int ; (* nombre d'états : numérotés 0, 1, ..., nb-1 *)
	sigma : char array ; (* alphabet : lettres autorisées *)
	i : int list ; (* liste des états initiaux *)
	f : int list ; (* liste des états finaux *)
	delta : (int * char, int list) Hashtbl.t (* table de transitions *)
};;

(*_____Affichage_____*)

(* affiche une expression régulière d'un type quelconque *)
let rec affiche_exp (e : exp_reg) : unit =
	match e with
	| Vide -> Printf.printf "V"
	| Epsilon -> Printf.printf "E"
	| Symbole a -> print_char a
	| Union(e1,e2) -> affiche_exp e1 ; Printf.printf " | " ; affiche_exp e2
	| Concat(e1,e2) -> 
		begin
		match e1,e2 with
		| Union(_),Union(_) -> Printf.printf "(" ; affiche_exp e1 ; Printf.printf ")(" ; affiche_exp e2 ; Printf.printf ")"
		| Union(_),_ -> Printf.printf "(" ; affiche_exp e1 ; Printf.printf ")" ; affiche_exp e2
		| _,Union(_) -> affiche_exp e1 ; Printf.printf "(" ; affiche_exp e2 ; Printf.printf ")"
		| _ -> affiche_exp e1 ; affiche_exp e2
		end
	| Etoile(e1) -> 
		begin
		match e1 with
		| Union(_) -> Printf.printf "(" ; affiche_exp e1 ; Printf.printf ")*"
		| Concat(_) -> Printf.printf "(" ; affiche_exp e1 ; Printf.printf ")*"
		| _ -> affiche_exp e1 ; Printf.printf "*"
		end
	;;

let ajouter_transition (a : automate) (q1 : int) (lettre : 'a) (q2 : int) : unit =
	assert((q1 >= 0) && (q1 < a.nb));
	assert((q2 >= 0) && (q2 < a.nb));
	assert(Array.mem lettre (a.sigma));
	match Hashtbl.find_opt (a.delta) (q1,lettre) with
	| None -> Hashtbl.add (a.delta) (q1,lettre) [q2]
	| Some l -> if not (List.mem q2 l) then
		    Hashtbl.replace (a.delta) (q1,lettre) (q2::l)
;;

(* construit un automate à partir de ses champs *)
(* les transitions sont données sous forme d'une liste de triplets (q1,b,q2) *)
let creer_automate (nb_etats : int) (alphabet : 'a array) (initiaux : int list) (acceptants : int list) (liste_transitions : (int * 'a * int) list) : automate =
	let a = { nb = nb_etats ; sigma = alphabet ; i = initiaux ; f = acceptants ;
delta = Hashtbl.create 1} in
	List.iter (fun (q1,b,q2) -> ajouter_transition a q1 b q2) liste_transitions ;
	a
;;
(* 
Q1)
Les langages L(p,q) pour p,q dans {0,1} pour l'automate du sujet sont définis par :
- L00 = a+
- L01 = a*b+
- L10 = existe pas (état 0 inatégnable depuis l'état 1)
- L11 = b+ (non acceptant)
*)
(*
Q2)
L(p,q,0) est l'ensemble des mots/lettre reconnus par une arrete entre p et q dans l'automate
*)

(*Q3*)
type exp_matrix = exp_reg array array;;

(*Q4*)
let matrice_initial(a : automate): exp_matrix =
	let m = Array.make_matrix a.nb a.nb Vide in 
	Hashtbl.iter (fun (q1,b) l ->
		List.iter (fun q2 ->
			match m.(q1).(q2) with
			| Vide -> m.(q1).(q2) <- Symbole b
			| _ -> m.(q1).(q2) <- Union(m.(q1).(q2), Symbole b)
		) l
	) a.delta;
	m
;;

(*
Q5)
On calcule L(p,q,k+1) à partir de L(p,q,k) en utilisant la formule :
L(p,q,k+1) = L(p,q,k) |  L(p,k,k) L(k,k,k)* L(k,q,k) 
On initialise la matrice avec k = 0, puis on itère jusqu'à k = n-1
*)

(*Q6*)
let matrice_finale (a: automate): exp_matrix =
	let m = ref(matrice_initial a) in
	for k = 0 to a.nb - 1 do
		let m_new = Array.make_matrix a.nb a.nb Vide in
		for p = 0 to a.nb - 1 do
			for q = 0 to a.nb - 1 do
				let lpq = !m.(p).(q) in
				let lpk = !m.(p).(k) in
				let lkk = !m.(k).(k) in
				let lkq = !m.(k).(q) in
				let nouvelle_valeur =
					match lpq, lpk, lkk, lkq with
					| Vide, Vide, _, _ -> Vide (*Vide | Vide (pas de chemin de p a q passant par k)*)
					| Vide, _, _, Vide -> Vide (*Vide | Vide (pas de chemin de p a q passant par k)*)
					| Vide, _, Vide, _ -> Concat(lpk, lkq) (*Vide | lpk lkq (pas de boucle de k a k)*)
					| Vide, _, _, _ -> Concat(lpk, Concat(Etoile(lkk), lkq)) (*Vide | lpk lkk* lkq (boucle de k a k)*)
					| _, Vide, _, _ -> lpq 	(*lpq | Vide (pas de chemin de p a q passant par k)*)
					| _, _, Vide, _ -> Union(lpq, Concat(lpk, lkq)) (*lpq | lpk lkq (pas de boucle de k a k)*)
					| _, _, _, Vide -> lpq (*lpq | Vide (pas de chemin de p a q passant par k)*)
					| _, _, _, _ -> Union(lpq, Concat(lpk, Concat(Etoile(lkk), lkq))) (*lpq | lpk lkk* lkq*)
				in
				m_new.(p).(q) <- nouvelle_valeur
			done
		done;
	m := m_new;
	done;
	!m
;;

(*
Q7) la fonction matrice_finale calcule (n^2+card(delta))+n^3 opérations expression régulière
*)
(*
Q8) L(A) est Union pour q dans F et i dans I des L(i,q,n-1) U Epsilon si il existe un i dans I inter F sinon Lang(Vide)
*)

let mcnaughton_yamada (a : automate) : exp_reg =
	let mf = matrice_finale a in
	let lang = ref Vide in
	List.iter (fun i ->
		List.iter (fun qf ->
			lang := Union(!lang, mf.(i).(qf))
		) a.f
	) a.i;
	if List.exists (fun x -> List.mem x a.f) a.i then
		lang := Union(!lang, Epsilon);
	!lang

let auto = creer_automate 2 [| 'a' ; 'b' |] [0] [0;1] [(0,'a',0) ; (0,'b',1) ; (1,'b',1)];;

(*let mat_test = matrice_finale auto;;*)

let exp_test = mcnaughton_yamada auto;;

affiche_exp exp_test;;