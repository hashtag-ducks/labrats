describe("TabGroupTemplate model", function() {
    var tab_group_template;

    beforeEach(function() {
        tab_group_template = new Labrats.Models.TabGroupTemplate({
            id: 1,
            page_template_id: 1,
            box_templates: [
                { ordering: 1, type: 'TextBoxTemplate' },
                { ordering: 3, type: 'DrawBoxTemplate' },
                { ordering: 2, type: 'TextBoxTemplate' }
            ]
        }, { parse: true });
    });

    it("sorts its box templates in ascending order", function() {
        var orderings = tab_group_template.get('box_templates').pluck('ordering');
        expect(orderings).toEqual([1, 2, 3]);
    });

    it("parses its box templates into a collection", function() {
        expect(tab_group_template.get('box_templates').length).toEqual(3);
    });

    it("is not valid without a page template ID", function() {
        tab_group_template.set('page_template_id', 0);
        expect(tab_group_template.isValid()).toBe(false);
    });

    it("uses the nested resource URL with /page_templates", function() {
        expect(tab_group_template.url()).toMatch(/\/page_templates\/\d\/tab_group_templates/);
    });
});
