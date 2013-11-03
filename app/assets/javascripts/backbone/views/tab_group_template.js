Labrats.Views.TabGroupTemplate = Backbone.View.extend({
    events: {
        'click .new-box': 'newBox',
        'click .delete-tab-group': 'delete'
    },

    initialize: function() {
        this.render();
    },

    render: function() {
        var tpl = $('#tab_group_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
        var self = this;
        this.model.get('box_templates').forEach(function(box) {
            var ele = $('<li></li>');
            self.$el.find('ul.boxes').append(ele);
            var boxView = new Labrats.Views[box.get('type')]({
                model: box,
                el: ele
            });
        });
    },

    newBox: function(event) {
        event.preventDefault();
        var type = $(event.currentTarget).data('box-type');
        var box_model = new Labrats.Models[type]({
            tab_group_template_id: this.model.get('id'),
            type: type
        });
        var self = this;
        box_model.save({}, {
            success: function(response) {
                box_model = new Labrats.Models[type](
                    response.attributes
                );
                var boxEle = $('<li></li>');
                self.$el.find('ul.boxes').append(boxEle);
                var boxView = new Labrats.Views[type]({
                    model: box_model,
                    el: boxEle
                });
                self.model.get('box_templates').add(box_model);
            },
            error: function() {
                console.log('error saving ' + type);
            }
        });
    },

    delete: function(event) {
        event.preventDefault();
        this.model.destroy({
            url: this.model.url() + '/' + this.model.get('id')
        });
        this.$el.remove();
    }
});
