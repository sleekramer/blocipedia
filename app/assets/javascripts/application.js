// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

marked.setOptions({
  highlight: function (code) {
    return require('highlight.js').highlightAuto(code).value;
  }
});

var convertMarkdown = function(source, target) {
  var html = $(source).val();
  $(target).html(marked(html));
};

$(document).ready(function(){
  $('#wiki_title').keyup(function(){
    convertMarkdown($(this), '#markdown_title')
  });
  $('#wiki_body').keyup(function(){
    convertMarkdown($(this), '#markdown_body')
  });
});
