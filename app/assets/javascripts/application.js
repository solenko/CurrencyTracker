//= require jquery
//= require jquery_ujs
//= require jquery.filtertable.js
//= require_self
//= require_tree .

$(function(){
  $('table.filterable').filterTable();
});

$(function() {
    $('.select-all-control').on('click', function() {
     $('input[type="checkbox"]', $(this.form)).prop('checked', $(this).prop('checked'))
    });
});