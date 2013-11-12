Labrats.Views.TabGroupTemplate = Backbone.View.extend({
    events: {
        'click .new-box': 'newBox',
        'click .delete-box': 'deleteBox',
        'click .delete-tab-group': 'delete',
        'click ul.boxes li a': 'switch',
        'dblclick ul.boxes li a': 'editName',
        'blur a[contenteditable=true]': 'setName'
    },

    initialize: function() {
        this.render();
        this.$el.find("ul.boxes li a").each(function() {
            $(this).addClass('inactive').removeClass('active');
        });
        if(this.model.get('box_templates').length > 0) {
            this.selectBox(this.$el.find("ul.boxes li a").first());
        }
    },

    render: function() {
        var tpl = $('#tab_group_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
        var self = this;
        this.model.get('box_templates').forEach(function(box) {
            var id = box.get('id');
            var tab = $('<li><a href="#" id="'+box.get('type')+box.get('id')+'">'+box.get('name')+'</a><span class="glyphicon glyphicon-remove"></span></li>');
            var ele = $('<div></div>');
            self.$el.find('ul.boxes').append(tab);
            self.$el.find('ul.boxes').after(ele);
            var boxView = new Labrats.Views[box.get('type')]({
                model: box,
                el: ele
            });
            self.$el.find('#' + box.get('type') + box.get('id')).text(box.get('name'));
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
                var tab = $(
                    '<li><a href="#" id="' +
                        box_model.get('type') +
                        box_model.get('id') +
                        '">' +
                        box_model.get('name') +
                        '</a></li>'
                );
                var boxEle = $('<div></div>');
                self.$el.find('ul.boxes').append(tab);
                self.$el.find('ul.boxes').after(boxEle);
                var boxView = new Labrats.Views[type]({
                    model: box_model,
                    el: boxEle
                });
                boxEle.find('.box').addClass('hidden');
                self.model.get('box_templates').add(box_model);
                self.selectBox(tab.children('a'));
            },
            error: function() {
                console.log('error saving ' + type);
            }
        });
    },

    deleteBox: function(event) {
        event.preventDefault();
        var tab = this.$el.find('ul.boxes li a.active');
        var parsedID = this.parseID(tab.attr('id'));
        var ele = this.$el.find('#' + parsedID[0] + parsedID[1]);
        var box = this.findBox(parseInt(parsedID[1]));
        this.model.get('box_templates').remove(box);
        box.destroy({
            url: box.url() + '/' + box.get('id')
        });
        ele.remove();
        var type = parsedID[0].match(/[A-Z][a-z]*/g).map(function(s) { return s.toLowerCase(); }).join("-").replace(/-template/, '');
        this.$el.find('#' + type + '-' + parsedID[1]).remove();
        if(this.model.get('box_templates').length > 0) {
            this.selectBox(this.$el.find("ul.boxes li a").first());
        }
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
        this.selectBox($(event.currentTarget));
    },

    parseID: function(s) {
        return [s.match(/[^\d]+/)[0], s.match(/\d+/)[0]];
    },

    editName: function(event) {
        event.preventDefault();
        var ele = $(event.currentTarget);
        ele.attr('contenteditable', 'true');
    },

    setName: function(event) {
        event.preventDefault();
        var ele = $(event.currentTarget);
        ele.attr('contenteditable', 'false');
        var text = ele.text();
        var id = parseInt(this.parseID(ele.attr('id'))[1]);
        var box = this.findBox(id);
        box.set('name', text);
    },

    selectBox: function(boxTab) {
        this.$el.find("ul.boxes li a").each(function() {
            $(this).addClass('inactive').removeClass('active');
        });
        boxTab.addClass('active').removeClass('inactive');
        this.$el.find("div.box").addClass('hidden').removeClass('displayed');
        var parsedID = this.parseID(boxTab.attr('id'));
        var type = parsedID[0];
        var id = parsedID[1];
        type = type.match(/[A-Z][a-z]*/g).map(function(s) { return s.toLowerCase(); }).join("-").replace(/-template/, '');
        $("#"+type+"-"+id).addClass('displayed').removeClass('hidden');
    },

    findBox: function(id) {
        return this.model.get('box_templates').find(function(box) {
            return box.get('id') === id;
        });
    }
});
