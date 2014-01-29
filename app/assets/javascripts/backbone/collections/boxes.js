Labrats.Collections.Boxes = Backbone.Collection.extend({
    model: Labrats.Models.Box,

    url: '/boxes',

    comparator: 'ordering'
});
