describe("PageTemplate model", function() {
    var page_template;

    beforeEach(function() {
        page_template = new Labrats.Models.PageTemplate({
            id: 1,
            notebook_id: 1,
            tab_group_templates: [
                {ordering: 1},
                {ordering: 3},
                {ordering: 2}
            ]
        }, { parse: true });
    });

    it("sorts its tab templates in ascending order", function() {
        var orderings = page_template.get('tab_group_templates').pluck('ordering');
        expect(orderings).toEqual([1, 2, 3]);
    });

    it("parses its tab group templates into a collection", function() {
        expect(page_template.get('tab_group_templates').length).toEqual(3);
    });

    it("is not valid without a notebook ID", function() {
        page_template.set('notebook_id', 0);
        expect(page_template.isValid()).toBe(false);
    });

    it("uses the nested resources url with /notebooks/", function() {
        expect(page_template.url()).toMatch(/\/notebooks\/\d\/page_templates/);
    });
});
