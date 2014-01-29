Labrats.Collections.TabGroups = Backbone.Collection.extend({
    model: Labrats.Models.TabGroup,

    url: '/tab_groups',

    comparator: 'ordering'
});
