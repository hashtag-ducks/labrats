Labrats.Models.Notebook = Backbone.Model.extend({
    defaults: {
        name: ''
    },

    /*
     * Rails is sending nested JSON responses, so we need to parse out
     * said JSON and turn it into the correct models.
     */
    parse: function(response) {
        response.pages = new Labrats.Collections.Pages(
            _.map(response.pages, function(page_JSON) {
                return new Labrats.Models.Page(page_JSON, {parse: true});
            })
        );
        console.log(response);
        return response;
    }
});
