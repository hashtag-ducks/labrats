Labrats.Models.TabGroup = Backbone.Model.extend({
    url: function() {
        return '/pages/' + this.get('page_id') + '/tab_groups';
    },

    defaults: {
        page_id: 0
    },

    toJSON: function() {
        return {
            tab_group: this.attributes
        };
    },

    validate: function(attrs) {
        if(attrs.page_id === 0) {
            return "Page ID can't be 0";
        }
    },

    // See Labrats.Models.Notebook
    parse: function(response) {
        response.boxes = new Labrats.Collections.Boxes(
            _.map(response.boxes, function(box_JSON) {
                return new Labrats.Models.Box(box_JSON, {parse: true});
            })
        );
        return response;
    }
});
