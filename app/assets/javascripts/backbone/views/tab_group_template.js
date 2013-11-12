Labrats.Views.TabGroupTemplate = Backbone.View.extend({
    events: {
        'click .new-box': 'newBox',
        'click .delete-tab-group': 'delete',
        'click ul.boxes li a': 'switch'
    },

    initialize: function() {
        this.render();
        $("ul.boxes li a").each(function() {
            $(this).addClass('inactive').removeClass('active');
        });
        $("ul.boxes li a").first().addClass("active").removeClass("inactive");
        $("div.box").addClass('hidden').removeClass('displayed');
        var id = $("ul.boxes li a").first().attr('id');
        var type = id.substr(0, id.length-1);
        id = id.substring(id.length-1);
        type = type.match(/[A-Z][a-z]*/g).map(function(s) { return s.toLowerCase(); }).join("-").replace(/-template/, '');
        $("#"+type+"-"+id).addClass('displayed').removeClass('hidden');
    },

    render: function() {
        var tpl = $('#tab_group_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
        var self = this;
        this.model.get('box_templates').forEach(function(box) {
            var id = box.get('id');
            var tab = $('<li><a href="#" id="'+box.get('type')+box.get('id')+'">'+box.get('name')+'</a></li>');
            var ele = $('<div></div>');
            self.$el.find('ul.boxes').append(tab);
            self.$el.find('ul.boxes').after(ele);
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
    },

    switch: function(event) {
        event.preventDefault();
        $("ul.boxes li a").each(function() {
           $(this).addClass('inactive').removeClass('active');
        });

        $(event.currentTarget).addClass('active').removeClass('inactive');
        $("div.box").addClass('hidden').removeClass('displayed');
        var id = $(event.currentTarget).attr('id');
        var type = id.substr(0, id.length-1);
        id = id.substring(id.length-1);
        type = type.match(/[A-Z][a-z]*/g).map(function(s) { return s.toLowerCase(); }).join("-").replace(/-template/, '');
        $("#"+type+"-"+id).addClass('displayed').removeClass('hidden');
    }
});
