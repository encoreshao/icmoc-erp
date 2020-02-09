function checkAll(id, checked) {
  $('#'+id).find('input[type=checkbox]:enabled').prop('checked', checked);
}
