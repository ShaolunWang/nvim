index:
	zoekt-index -ignore_dirs ".env,.direnv" .
get in_str ft:
	zoekt -index_dir . '{{in_str}} file:{{ft}}'
search in_str ft:
	zoekt -index_dir . '{{in_str}} file:{{ft}}' | fzf
