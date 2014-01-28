describe("BoxTemplate model", function() {
    var box_template;
    beforeEach(function() {
        box_template = new Labrats.Models.BoxTemplate({
            id: 1,
            tab_group_template_id: 1
        });
    });

    it("uses the nested resource URL with tab_group_templates", function() {
        expect(box_template.url()).toMatch(/\/tab_group_templates\/\d\/box_templates/);
    });

    it("isn't valid with a tab_group_template_id of 0", function() {
        box_template.set('tab_group_template_id', 0);
        expect(box_template.isValid()).toBe(false);
    });

    it("has a default name", function() {
        expect(box_template.get('name')).toBe('Text Box');
    });

    it("returns its attributes as a JSON representation", function() {
        expect(box_template.toJSON()).toEqual({
            box_template: {
                id: 1,
                tab_group_template_id: 1,
                name: "Text Box"
            }
        });
    });
});
