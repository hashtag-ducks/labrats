describe("Notebook model", function() {
    var owner_notebook, shared_notebook;

    beforeEach(function() {
        owner_notebook = new Labrats.Models.Notebook({
             page_templates: [
                 {ordering: 1},
                 {ordering: 3},
                 {ordering: 2}
             ]
        }, { parse: true });
        shared_notebook = new Labrats.Models.Notebook({
             pages: [
                 {ordering: 1},
                 {ordering: 3},
                 {ordering: 2}
             ]
        }, { parse: true });
    });

    it("sorts page templates in ascending order", function() {
        var orderings = owner_notebook.get('page_templates').pluck('ordering');
        expect(orderings).toEqual([1, 2, 3]);
    });

    /*
     * The following two tests can't actually assert the type of the
     * objects contained in `page_templates` and `pages`, so just
     * assert that they're actually there and look like the correct
     * Backbone collections.
     */

    it("parses its JSON into a collection of PageTemplates if they are present", function() {
        expect(owner_notebook.get('page_templates').length).toBe(3);
    });

    it("parses its JSON into a collection of Pages if they are present", function() {
        expect(shared_notebook.get('pages').length).toBe(3);
    });
});
