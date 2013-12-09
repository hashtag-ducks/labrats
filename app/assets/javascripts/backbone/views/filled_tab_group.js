//= require ./tab_group

Labrats.Views.FilledTabGroup = Labrats.Views.TabGroup.extend({
    templateName: '#tab_group-tpl',

    childSelector: 'boxes',


    tabTemplate: '<li>' +
        '<a href="#" id=<%= type %><%= id %>><%= name %></a>' +
        '</li>'
});
