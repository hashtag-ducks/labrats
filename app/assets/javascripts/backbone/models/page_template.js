Labrats.Models.PageTemplate = Backbone.Model.extend({
    url: function() {
        return '/notebooks/' + this.get('notebook_id') + '/page_templates';
    },

    defaults: {
        notebook_id: 0
    },

    toJSON: function() {
        return {
            page_template: this.attributes
        };
    },

    validate: function(attrs) {
        if(attrs.notebook_id === 0) {
            return "Notebook ID can't be 0";
        }
    },

    // See Labrats.Models.Notebook
    parse: function(response) {
        // On update Rails doesn't send anything, so let's make sure
        // this is defined
        if(!response) {
            return;
        }
        response.tab_group_templates = new Labrats.Collections.TabGroupTemplates(
            _.map(response.tab_group_templates, function(tab_group_JSON) {
                return new Labrats.Models.TabGroupTemplate(tab_group_JSON, {parse: true});
            })
        );
        return response;
    }
});
