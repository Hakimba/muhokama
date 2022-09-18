(** All topic-related services. *)

open Lib_service

(** Prompt the list of topics. *)
val list : (Dream.request, Dream.response) Service.t

(** Prompt the list of topics grouped by category. *)
val list_by_category : (Dream.request, Dream.response) Service.t

(** Prompte a topic creation page. *)
val create : (Dream.request, Dream.response) Service.t

(** Save a new topic. *)
val save : (Dream.request, Dream.response) Service.t

(** Show one topic. *)
val show : (Dream.request, Dream.response) Service.t

(** Answer to a topic. *)
val answer : (Dream.request, Dream.response) Service.t

(** Archive to a topic. *)
val archive : (Dream.request, Dream.response) Service.t
