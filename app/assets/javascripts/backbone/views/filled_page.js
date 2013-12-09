//= require ./page

Labrats.Views.FilledPage = Labrats.Views.Page.extend({
    templateName: "#page-tpl",

    childType: 'FilledTabGroup',
    childSelector: 'tab_groups'
});
