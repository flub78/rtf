<?php
/*
 * CITemplate English translation
 *
 * Metadata test strings
 */

/*
 * meta_test1
 */
$lang['title_meta_test1'] = "Metadata test table";
$lang['title_meta_test1_form'] = "Metadata test edition form";
$lang['title_meta_test1_create'] = "Metadata test creation form";

$lang['heading_meta_test1_name'] = "Name";
$lang['heading_meta_test1_description'] = "Description";
$lang['heading_meta_test1_email'] = "Email address";
$lang['heading_meta_test1_active'] = "Active";
$lang['heading_meta_test1_expiration_date'] = "Expiration date";

$lang['placeholder_meta_test1_name'] = "Name";
$lang['placeholder_meta_test1_description'] = "Description";
$lang['placeholder_meta_test1_expiration_date'] = "Expiration date";

$lang['label_meta_test1_name'] = "Name";
$lang['label_meta_test1_description'] = "Description";
$lang['label_meta_test1_email'] = "Email address";

{{#tables}}
/*
 * table {{{name}}}
 */	
	{{#fields}}
$lang['heading_{{{name}}}_{{.}}'] = "{{.}}";		
	{{/fields}}
	{{#fields}}
$lang['label_{{{name}}}_{{.}}'] = "{{.}}";
	{{/fields}}
	{{#fields}}
$lang['placeholder_{{{name}}}_{{.}}'] = "{{.}}";
	{{/fields}}
	
{{/tables}}