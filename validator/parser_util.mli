val print_position : out_channel -> Lexing.lexbuf -> unit
val parse_with_error : Lexing.lexbuf -> Ir.tterm list list
val parse_file : bytes -> Ir.tterm list list
