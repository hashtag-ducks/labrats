Labrats.Views.TabGroup = Backbone.View.extend({
    events: {
        'click ul.boxes li': 'switch'
    },

    initialize: function() {
        this.render();
        var self = this;
        this.model.get(this.childSelector).forEach(function(box) {
            var id = box.get('id');
            var tab = $(_.template(self.tabTemplate, {
                type: box.get('type'),
                id: box.get('id'),
                name: box.get('name')
            }));
            var ele = $('<div></div>');
            self.$el.find('li.tab-group-btns').before(tab);
            self.$el.find('ul.boxes').after(ele);
            var boxView = new Labrats.Views[box.get('type')]({
                model: box,
                el: ele
            });
            self.$el.find('#' + box.get('type') + box.get('id')).text(box.get('name'));
        });
        if(this.model.get(this.childSelector).length > 0) {
            this.selectBox(this.$el.find("ul.boxes li a").first());
        }
    },

    render: function() {
        var tpl = $(this.templateName).text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
    },

    switch: function(event) {
        event.preventDefault();
        this.selectBox($(event.currentTarget).children('a'));
    },

    selectBox: function(boxTab) {
	if(boxTab.hasClass('dropdown-toggle')) {
	    return;
	}
        this.$el.find("ul.boxes li").each(function() {
            $(this).addClass('inactive').removeClass('active');
        });
        boxTab.parent().addClass('active').removeClass('inactive');
        this.$el.find("div.box").addClass('hidden').removeClass('displayed');
        var parsedID = this.parseID(boxTab.attr('id'));
        var type = parsedID[0];
        var id = parsedID[1];
        type = type.match(/[A-Z][a-z]*/g).map(function(s) {
            return s.toLowerCase();
        }).join("-").replace(/-template/, '');
        $("#"+type+"-"+id).addClass('displayed').removeClass('hidden');
    },

    parseID: function(s) {
        return [s.match(/[^\d]+/)[0], s.match(/\d+/)[0]];
    }
});
