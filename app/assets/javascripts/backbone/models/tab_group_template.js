Labrats.Models.TabGroupTemplate = Backbone.Model.extend({
    url: function() {
        return '/page_templates/' + this.get('page_template_id') + '/tab_group_templates';
    },

    defaults: {
        page_template_id: 0
    },

    toJSON: function() {
        return {
            tab_group_template: this.attributes
        };
    },

    validate: function(attrs) {
        if(attrs.page_template_id === 0) {
            return "Page template ID can't be 0";
        }
    },

    // See Labrats.Models.Notebook
    parse: function(response) {
        response.box_templates = new Labrats.Collections.BoxTemplates(
            _.map(response.box_templates, function(box_JSON) {
                // Slight sneakiness here so that we instantiate the
                // correct Box model type -- Rails gives us the name
                // of the box class, so as long as there's a
                // one-to-one mapping between Rails and Backbone
                // models this works
                return new Labrats.Models[box_JSON.type](box_JSON, {parse: true});
            })
        );
        return response;
    }
});
