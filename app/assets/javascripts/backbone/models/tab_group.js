Labrats.Models.TabGroup = Backbone.Model.extend({
    parse: function(response) {
        response.boxes = new Labrats.Collections.Boxes(
            _.map(response.boxes, function(box_JSON) {
                return new Labrats.Models[box_JSON.type](box_JSON, {parse: true});
            })
        );
        return response;
    }
});
