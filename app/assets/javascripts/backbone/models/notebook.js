Labrats.Models.Notebook = Backbone.Model.extend({
    defaults: {
        name: ''
    },

    /*
     * Rails is sending nested JSON responses, so we need to parse out
     * said JSON and turn it into the correct models.
     */
    parse: function(response) {
        response.page_templates = new Labrats.Collections.PageTemplates(
            _.map(response.page_templates, function(page_JSON) {
                return new Labrats.Models.PageTemplate(
                    _.extend({is_owner: response.is_owner}, page_JSON),
                    {parse: true}
                );
            })
        );
        return response;
    }
});
