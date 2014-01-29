Labrats.Models.Page = Backbone.Model.extend({
    parse: function(response) {
        response.tab_groups = new Labrats.Collections.TabGroups(
            _.map(response.tab_groups, function(tab_group_JSON) {
                return new Labrats.Models.TabGroup(tab_group_JSON, {parse: true});
            })
        );
        return response;
    }
});
