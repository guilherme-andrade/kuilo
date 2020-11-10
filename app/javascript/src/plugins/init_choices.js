import Choices from 'choices.js';

document.addEventListener('turbolinks:load', initChoices)

function initChoices(e) {
  const selects = document.querySelectorAll('select[data-choices="true"]');
  selects.forEach(createChoices)
}

function createChoices(select) {
  if (select.classList.contains('flatpickr-monthDropdown-months')) {
    return;
  }

  new Choices(select, {
    classNames: {
      containerOuter: 'choices',
      containerInner: 'choices__inner form-select bg-white border border-medium',
      input: 'choices__input',
      inputCloned: 'choices__input--cloned',
      list: 'choices__list',
      listItems: 'choices__list--multiple',
      listSingle: 'choices__list--single',
      listDropdown: 'choices__list--dropdown',
      item: 'choices__item',
      itemSelectable: 'choices__item--selectable',
      itemDisabled: 'choices__item--disabled',
      itemOption: 'choices__item--choice',
      group: 'choices__group',
      groupHeading : 'choices__heading',
      button: 'choices__button',
      activeState: 'is-active',
      focusState: 'is-focused',
      openState: 'is-open',
      disabledState: 'is-disabled',
      highlightedState: 'is-highlighted',
      selectedState: 'is-selected',
      flippedState: 'is-flipped',
      selectedState: 'is-highlighted',
    }
  })
}
