/* 
 * Update July 2013, replace NEW_ID for double nested level
 * eg: nested_fields_for(:associations, f, title: "Associations", container_id: "association_NEW_ID")
 */
get_new_id = function() { return new Date().getTime(); }
replace_ids = function(s) { return s.replace(/NEW_RECORD/g, get_new_id).replace(/NEW_ID/g, get_new_id); }

/* 
 * Check if localized message is available...
 * should have been loaded by localize.xx.js
 */
try {
	confirm_msg = LANG.are_you_sure;
} catch(err) {
	confirm_msg = "Are you sure?";
}

function htmlDecode(value){ 
  return $('<div/>').html(value).text(); 
}

/* 
 * NEW SYNTAX Jquery 1.7 syntax for live events 
 * http://api.jquery.com/live/
 */
$(document).on('click', '.add_child', function() {
	var assoc = $(this).attr('data-association');
  var jstemplate = htmlDecode(eval(assoc));
  
  //var insertionNode = $(this).next('.nested-wrapper');
  //insertionNode.append(replace_ids(jstemplate));
  
  var insertionNode = "#" + $(this).attr('data-target');
  insertionNode = $(insertionNode);
  insertionNode.append(replace_ids(jstemplate));

  return false;
});

$(document).on('click', '.remove_child.dynamic', function() {
	if (confirm(confirm_msg)) {
    var deletionNode = $(this).closest(".nested-fields");
    deletionNode.remove();
    return false;
  }
});

$(document).on('click', '.remove_child.existing', function() {
	if (confirm(confirm_msg)) {
    var deletionNode = $(this).closest(".nested-fields");
    $(this).prev("input[type=hidden]").val("1");
    $(this).closest(".nested-fields").hide();
    return false;
	}
});
