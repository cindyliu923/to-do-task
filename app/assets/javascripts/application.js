// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require select2
//= require bootstrap
//= require datetimepicker
$(document).on('turbolinks:load', function () {
  $("#task_tag_items").select2({
    theme: "bootstrap",
    tags: true,
    tokenSeparators: [',', ';', '，', '；', ' '],
    // 為了可以輸入中文
    createTag: function(params) {
      if (/[,;，； ]/.test(params.term)) {
        var str = params.term.trim().replace(/[,;，；]*$/, '');
        return {
          id: str,
          text: str
        }
      } else {
        return null;
      }
    }
  });

  // 為了可以直接 enter
  $(document).on('keyup', '.select2-selection--multiple .select2-search__field', function(event){
    if(event.keyCode == 13){
      var $this = $(this);
      var optionText = $this.val();
      if(optionText != "" && $this.find("option[value='" + optionText + "']").length === 0){
        var $select = $this.parents('.select2-container').prev("select");
        var newOption = new Option(optionText, optionText, true, true);
        $select.append(newOption).trigger('change');
        $this.val('');
      }
    }
  });

  $('#datetimepicker').datetimepicker();
});
