import { test } from 'qunit';
import moduleForAcceptance from 'audiences/tests/helpers/module-for-acceptance';

moduleForAcceptance('Acceptance | list audience folders');

test('should redirect to audience folders route', function (assert) {
  visit('/');

  andThen(() => assert.equal(currentURL(), '/folders'));
});

test('should list audience folders', function (assert) {
  visit('/');
  andThen(() =>
    assert.equal(
        find('.audience-folders__list__item').length, 
        4, 
        'should see 4 folders'
      )
  );
});

test('should open audience folder', function (assert) {
  visit('/');
  var firstItemHref;
  let firtFolderLinkSelector = '.audience-folders__list__item:first';
  andThen(() => firstItemHref = find(firtFolderLinkSelector).attr('href'));

  click(firtFolderLinkSelector);

  andThen(() => assert.equal(currentURL(), firstItemHref, 'should open first folder'));
});

test('should open audience folder and show subfolders', function (assert) {
  visit('/');
  var itemHref;
  let folderLinkSelector = '.audience-folders__list__item:eq(3)';
  andThen(() => itemHref = find(folderLinkSelector).attr('href'));

  click(folderLinkSelector);

  andThen(() => assert.equal(currentURL(), itemHref, 'should open first folder'));

  andThen(() => assert.equal('New Group 2', find('.audience-folders__list__item').text().trim(), 'Shown subfolder'));

});