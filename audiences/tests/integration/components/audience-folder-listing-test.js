import { moduleForComponent, test } from 'ember-qunit';
import Ember from 'ember';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('audience-folder-listing', 'Integration | Component | audience folder listing', {
  integration: true
});

test('Show folders', function(assert) {

  let folderItem = Ember.Object.create({
    id: 666,
    name: 'Some folder item name',
    parent: 123
  });
  this.set('folderItem', folderItem);
  this.render(hbs`{{audience-folder-listing folder=folderItem}}`);

  assert.equal(
    this.$('.audience-folders__list__item').text().trim(),
    folderItem.name,
    'Correct text in item'
  );

});
