module Create = struct
  let user_email_input =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field" ] ]
      [ label
          ~a:[ a_class [ "label" ]; a_label_for "register_user_email" ]
          [ txt "Adresse électronique" ]
      ; div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Email
                ; a_placeholder "you@domain.com"
                ; a_id "register_user_email"
                ; a_name Model.User.For_registration.user_email_key
                ; a_class [ "input" ]
                ]
              ()
          ]
      ; p
          ~a:[ a_class [ "help" ] ]
          [ txt "Il faut que l'adresse ressemble à une adresse mail."
          ; br ()
          ; txt "C'est l'adresse qui fera office d'identifiant sur le site."
          ]
      ]
  ;;

  let user_name_input =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field" ] ]
      [ label
          ~a:[ a_class [ "label" ]; a_label_for "register_user_name" ]
          [ txt "Nom d'utilisateur" ]
      ; div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Text
                ; a_placeholder "J. Doe"
                ; a_id "register_user_name"
                ; a_name Model.User.For_registration.user_name_key
                ; a_class [ "input" ]
                ]
              ()
          ]
      ; p
          ~a:[ a_class [ "help" ] ]
          [ txt
              "C'est un nom d'affichage, donc il faut que ça ait l'air un peu \
               sérieux."
          ]
      ]
  ;;

  let user_password_input =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field" ] ]
      [ label
          ~a:[ a_class [ "label" ]; a_label_for "register_user_password" ]
          [ txt "Mot de passe" ]
      ; div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Password
                ; a_placeholder "azerty123"
                ; a_id "register_user_password"
                ; a_name Model.User.For_registration.user_password_key
                ; a_class [ "input" ]
                ]
              ()
          ]
      ; p
          ~a:[ a_class [ "help" ] ]
          [ txt "Au minimum 7 caractères... parce que ce site est sécure." ]
      ]
  ;;

  let confirm_user_password_input =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field" ] ]
      [ label
          ~a:
            [ a_class [ "label" ]
            ; a_label_for "register_confirm_user_password"
            ]
          [ txt "Confirmation du mot de passe" ]
      ; div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Password
                ; a_placeholder "azerty123"
                ; a_id "register_confirm_user_password"
                ; a_name Model.User.For_registration.confirm_user_password_key
                ; a_class [ "input" ]
                ]
              ()
          ]
      ; p
          ~a:[ a_class [ "help" ] ]
          [ txt
              "Ici il faut réécrire le même mot de passe, c'est juste pour \
               être sur."
          ]
      ]
  ;;

  let submit_button =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field" ] ]
      [ div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Submit
                ; a_value "Valider !"
                ; a_class [ "button"; "is-link" ]
                ]
              ()
          ]
      ]
  ;;

  let registration_form csrf_token =
    let open Tyxml.Html in
    form
      ~a:[ a_method `Post; a_action "/user/new" ]
      [ Template.Util.csrf_input csrf_token
      ; user_email_input
      ; user_name_input
      ; user_password_input
      ; confirm_user_password_input
      ; submit_button
      ]
  ;;
end

module Connection = struct
  let user_email_input =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field"; "mb-4" ] ]
      [ label
          ~a:[ a_class [ "label" ]; a_label_for "connect_user_email" ]
          [ txt "Adresse électronique" ]
      ; div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Email
                ; a_placeholder "you@domain.com"
                ; a_id "connect_user_email"
                ; a_name Model.User.For_connection.user_email_key
                ; a_class [ "input" ]
                ]
              ()
          ]
      ]
  ;;

  let user_password_input =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field"; "mb-4" ] ]
      [ label
          ~a:[ a_class [ "label" ]; a_label_for "connect_user_password" ]
          [ txt "Mot de passe" ]
      ; div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Password
                ; a_placeholder "azerty123"
                ; a_id "connect_user_password"
                ; a_name @@ Model.User.For_connection.user_password_key
                ; a_class [ "input" ]
                ]
              ()
          ]
      ]
  ;;

  let submit_button =
    let open Tyxml.Html in
    div
      ~a:[ a_class [ "field" ] ]
      [ div
          ~a:[ a_class [ "control" ] ]
          [ input
              ~a:
                [ a_input_type `Submit
                ; a_value "Se connecter !"
                ; a_class [ "button"; "is-link" ]
                ]
              ()
          ]
      ]
  ;;

  let connection_form csrf_token =
    let open Tyxml.Html in
    form
      ~a:[ a_method `Post; a_action "/user/auth" ]
      [ Template.Util.csrf_input csrf_token
      ; user_email_input
      ; user_password_input
      ; submit_button
      ]
  ;;
end

module List_active = struct
  let user_line user =
    let open Tyxml.Html in
    let Model.User.Saved.{ user_email; user_name; user_state; _ } = user in
    tr
      [ td [ txt user_name ]
      ; td [ txt user_email ]
      ; td
          ~a:[ a_class [ "has-text-centered" ] ]
          [ Template.Component.user_state_tag user_state ]
      ]
  ;;

  let all users =
    let open Tyxml.Html in
    let hd =
      thead
        [ tr
            [ th [ txt "Nom d'utilisateur" ]
            ; th [ txt "Courrier electronique" ]
            ; th ~a:[ a_class [ "has-text-centered" ] ] [ txt "Status" ]
            ]
        ]
    in
    table
      ~a:[ a_class [ "table"; "is-fullwidth"; "is-striped"; "is-bordered" ] ]
      ~thead:hd
    @@ List.map user_line users
  ;;
end

module List_moderable = struct
  let upgrade_btn =
    let open Tyxml.Html in
    input
      ~a:
        [ a_input_type `Submit
        ; a_class [ "button"; "is-success"; "is-small" ]
        ; a_name Model.User.For_state_changement.upgrade_key
        ; a_value "+"
        ]
      ()
  ;;

  let downgrade_btn =
    let open Tyxml.Html in
    input
      ~a:
        [ a_input_type `Submit
        ; a_class [ "button"; "is-danger"; "is-small" ]
        ; a_name Model.User.For_state_changement.downgrade_key
        ; a_value "-"
        ]
      ()
  ;;

  let action_for = function
    | Model.User.State.Admin -> []
    | Model.User.State.Inactive -> [ upgrade_btn ]
    | _ -> [ upgrade_btn; downgrade_btn ]
  ;;

  let change_state_form csrf user =
    let open Tyxml.Html in
    let Model.User.Saved.{ user_state; user_id; _ } = user in
    form ~a:[ a_method `Post; a_action "/admin/user/state" ]
    @@ [ input
           ~a:
             [ a_input_type `Hidden
             ; a_name Model.User.For_state_changement.user_id_key
             ; a_value user_id
             ]
           ()
       ; Template.Util.csrf_input csrf
       ]
    @ action_for user_state
  ;;

  let user_line csrf user =
    let open Tyxml.Html in
    let Model.User.Saved.{ user_email; user_name; user_state; _ } = user in
    tr
      [ td [ txt user_name ]
      ; td [ txt user_email ]
      ; td
          ~a:[ a_class [ "has-text-centered" ] ]
          [ Template.Component.user_state_tag user_state ]
      ; td
          ~a:[ a_class [ "has-text-centered" ] ]
          [ change_state_form csrf user ]
      ]
  ;;

  let all csrf users =
    let open Tyxml.Html in
    let hd =
      thead
        [ tr
            [ th [ txt "Nom d'utilisateur" ]
            ; th [ txt "Courrier electronique" ]
            ; th ~a:[ a_class [ "has-text-centered" ] ] [ txt "Status" ]
            ; th ~a:[ a_class [ "has-text-centered" ] ] [ txt "Action" ]
            ]
        ]
    in
    table
      ~a:
        [ a_class
            [ "table"
            ; "is-fullwidth"
            ; "is-narrow"
            ; "is-striped"
            ; "is-bordered"
            ]
        ]
      ~thead:hd
    @@ List.map (user_line csrf) users
  ;;
end

let create ?flash_info ~csrf_token () =
  Template.Layout.default
    ~lang:"fr"
    ~page_title:"Créer un compte"
    ?flash_info
    Tyxml.Html.
      [ div
          ~a:[ a_class [ "columns" ] ]
          [ div
              ~a:[ a_class [ "column"; "is-half" ] ]
              [ h1 ~a:[ a_class [ "title" ] ] [ txt "Se créer un compte" ]
              ; Create.registration_form csrf_token
              ]
          ]
      ]
;;

let login ?flash_info ~csrf_token () =
  Template.Layout.default
    ~lang:"fr"
    ~page_title:"Se connecter"
    ?flash_info
    Tyxml.Html.
      [ div
          ~a:[ a_class [ "columns" ] ]
          [ div
              ~a:[ a_class [ "column"; "is-two-fifths" ] ]
              [ h1 ~a:[ a_class [ "title" ] ] [ txt "Se connecter" ]
              ; Connection.connection_form csrf_token
              ]
          ]
      ]
;;

let list_active ?flash_info ?user users () =
  Template.Layout.default
    ~lang:"fr"
    ~page_title:"Utilisateurs"
    ?flash_info
    ?user
    Tyxml.Html.
      [ div
          ~a:[ a_class [ "columns" ] ]
          [ div
              ~a:[ a_class [ "column"; "is-full" ] ]
              [ h1 ~a:[ a_class [ "title" ] ] [ txt "Utilisateurs actifs" ]
              ; List_active.all users
              ]
          ]
      ]
;;

let list_moderable ?flash_info ~csrf_token ?user ~active ~inactive () =
  Template.Layout.default
    ~lang:"fr"
    ~page_title:"Utilisateurs"
    ?flash_info
    ?user
    Tyxml.Html.
      [ div
          ~a:[ a_class [ "columns" ] ]
          [ div
              ~a:[ a_class [ "column"; "is-full" ] ]
              [ h1 ~a:[ a_class [ "title" ] ] [ txt "Utilisateurs modérables" ]
              ; div
                  ~a:[ a_class [ "columns" ] ]
                  [ div
                      ~a:[ a_class [ "column"; "is-half" ] ]
                      [ h2
                          ~a:[ a_class [ "title"; "is-4" ] ]
                          [ txt "Utilisateurs inactifs" ]
                      ; List_moderable.all csrf_token inactive
                      ]
                  ; div
                      ~a:[ a_class [ "column"; "is-half" ] ]
                      [ h2
                          ~a:[ a_class [ "title"; "is-4" ] ]
                          [ txt "Utilisateurs actifs" ]
                      ; List_moderable.all csrf_token active
                      ]
                  ]
              ]
          ]
      ]
;;
