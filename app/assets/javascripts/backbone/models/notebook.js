Labrats.Models.Notebook = Backbone.Model.extend({
    defaults: {
        name: ''
    },

    /*
     * Rails is sending nested JSON responses, so we need to parse out
     * said JSON and turn it into the correct models.
     */
    parse: function(response) {
        // If `page_templates` is a key, this is being shown to the owner.
        if(response.page_templates) {
            response.page_templates.sort(function(p1, p2) {
                return p1.ordering >= p2.ordering;
            });
            response.page_templates = new Labrats.Collections.PageTemplates(
                _.map(response.page_templates, function(page_JSON) {
                    return new Labrats.Models.PageTemplate(page_JSON, {parse: true});
                })
            );
        }
        // Otherwise, to a user with access.
        else {
            response.pages.sort(function(p1, p2) {
                return p1.ordering >= p2.ordering;
            });
            response.pages = new Labrats.Collections.Pages(
                _.map(response.pages, function(page_JSON) {
                    return new Labrats.Models.Page(page_JSON, {parse: true});
                })
            );
        }
        return response;
    }
});
