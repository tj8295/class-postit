
},
error: function(xhr, status, error) {
element.trigger('ajax:error', [xhr, status, error]);
},
crossDomain: crossDomain
};
// There is no withCredentials for IE6-8 when
// "Enable native XMLHTTP support" is disabled
if (withCredentials) {
options.xhrFields = {
withCredentials: withCredentials
};
}
// Only pass url to `ajax` options if not blank
if (url) { options.url = url; }
var jqxhr = rails.ajax(options);
element.trigger('ajax:send', jqxhr);
return jqxhr;
} else {
return false;
}
},
// Handles "data-method" on links such as:
// <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
handleMethod: function(link) {
var href = rails.href(link),
method = link.data('method'),
target = link.attr('target'),
csrf_token = $('meta[name=csrf-token]').attr('content'),
csrf_param = $('meta[name=csrf-param]').attr('content'),
form = $('<form method="post" action="' + href + '"></form>'),
metadata_input = '<input name="_method" value="' + method + '" type="hidden" />';
if (csrf_param !== undefined && csrf_token !== undefined) {
metadata_input += '<input name="' + csrf_param + '" value="' + csrf_token + '" type="hidden" />';
}
if (target) { form.attr('target', target); }
form.hide().append(metadata_input).appendTo('body');
form.submit();
},
/* Disables form elements:
- Caches element value in 'ujs:enable-with' data store
- Replaces element text with value of 'data-disable-with' attribute
- Sets disabled property to true
*/
disableFormElements: function(form) {
form.find(rails.disableSelector).each(function() {
var element = $(this), method = element.is('button') ? 'html' : 'val';
element.data('ujs:enable-with', element[method]());
element[method](element.data('disable-with'));
element.prop('disabled', true);
});
},
/* Re-enables disabled form elements:
- Replaces element text with cached value from 'ujs:enable-with' data store (created in `disableFormElements`)
- Sets disabled property to false
*/
enableFormElements: function(form) {
form.find(rails.enableSelector).each(function() {
var element = $(this), method = element.is('button') ? 'html' : 'val';
if (element.data('ujs:enable-with')) element[method](element.data('ujs:enable-with'));
element.prop('disabled', false);
});
},
/* For 'data-confirm' attribute:
- Fires `confirm` event
- Shows the confirmation dialog
- Fires the `confirm:complete` event
Returns `true` if no function stops the chain and user chose yes; `false` otherwise.
Attaching a handler to the element's `confirm` event that returns a `falsy` value cancels the confirmation dialog.
Attaching a handler to the element's `confirm:complete` event that returns a `falsy` value makes this function
return false. The `confirm:complete` event is fired whether or not the user answered true or false to the dialog.
*/
allowAction: function(element) {
