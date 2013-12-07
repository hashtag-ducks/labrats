//= require ./page

Labrats.Views.FilledPage = Labrats.Views.Page.extend({
    templateName: "#page-tpl",

    childType: 'TabGroup',
    childSelector: 'tab_groups'
});
