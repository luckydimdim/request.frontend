import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/grid.dart';
import 'package:daterangepicker/daterangepicker.dart';

@Component(
    selector: 'request-settings',
    templateUrl: 'request_settings_component.html')
class RequestSettingsComponent implements OnInit, OnDestroy {
  static const String route_name = 'RequestSettings';
  static const String route_path = 'settings';
  static const Route route = const Route(
      path: RequestSettingsComponent.route_path,
      component: RequestSettingsComponent,
      name: RequestSettingsComponent.route_name,
      useAsDefault: true);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;

  Grid _materialsGrid;
  Grid _worksGrid;

  RequestSettingsComponent(this._router, this._resourcesLoaderService) {}

  @override
  void ngOnInit() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.add('mobile-open');
    document.body.classes.add('aside-menu-open');

    // TODO: Сделать более удобным переключение вкладок и показ/скрытие меню
    var oldActiveLink =
        querySelector('.aside-menu .nav-tabs li a.active') as AnchorElement;
    oldActiveLink.classes.remove('active');

    var newActiveLink =
        querySelector('.aside-menu .nav-tabs li a[href="#settings"]')
            as AnchorElement;
    newActiveLink.classes.add('active');

    var oldActivePanel =
        querySelector('.aside-menu .tab-content div.active') as DivElement;
    oldActivePanel.classes.remove('active');

    var newActivePanel =
        querySelector('.aside-menu .tab-content div[id="settings"]')
            as DivElement;
    newActivePanel.classes.add('active');

    // TODO: Продумать управления содержимым бокового меню
    var htmlElement = '''
    <h6>Создание заявки на проверку</h6>
      <div>
      <small class="text-muted">Выберите договор и укажите период для
      отображения списка работ и материалов.
      </small>
      </div>
      <div class="aside-options">
      <div class="clearfix mt-2">
      <form action="" method="post" class="ng-pristine ng-valid">
      <div class="form-group">
      <div class="input-group">
      <span class="input-group-addon"><i class="fa fa-file"></i>
      </span>
      <input type="text" id="contract-number"
      name="contract-number" class="form-control"
      placeholder="Договор"/>
      </div>
      </div>
      <div class="form-group">
      <div class="input-group">
      <span class="input-group-addon"><i
      class="fa fa-calendar"></i>
      </span>
      <input date-range-picker="" id="request-date-range-picker"
      placeholder="Период"
      class="form-control date-picker ng-pristine ng-valid ng-isolate-scope ng-not-empty ng-touched"
      type="text" ng-model="date" options="opts"
      style=""/>
      </div>
      </div>
      <div class="form-group form-actions">
      <button type="submit" class="btn btn-sm btn-success">
      Показать работы и материалы
      </button>
      </div>
      </form>
      </div>
      </div>
      <hr/>''';

    newActivePanel.innerHtml = htmlElement;

    DateRangeInit();
    WorksGridInit();
    //MaterialsGridInit(); // FIXME: перерисовывать таблицу при активации таба
  }

  void DateRangeInit() {
    var options = new DateRangePickerOptions();

    new DateRangePicker(
        this._resourcesLoaderService, '#request-date-range-picker', options);
  }

  void WorksGridInit() {
    var showOptions = new ShowOptions()
      ..columnHeaders = true
      ..emptyRecords = true
      ..selectColumn = true
      ..header = false;

    var columns = new List<Column>();

    columns.add(
        new Column(field: 'Code', caption: 'Код', size: '100px', frozen: true));
    columns.add(new Column(
        field: 'Name',
        caption: 'Наименование этапа/работы',
        size: '300px',
        frozen: true));

    columns.add(new Column(
        field: 'BeginDate', caption: 'Начало', size: '100px', render: 'date'));
    columns.add(new Column(
        field: 'EndDate', caption: 'Окончание', size: '100px', render: 'date'));
    columns.add(new Column(field: 'Unit', caption: 'Ед. изм.', size: '100px'));
    columns.add(new Column(field: 'Amount', caption: 'Объем', size: '100px'));
    columns.add(new Column(field: 'Cost', caption: 'Стоимость', size: '100px'));
    columns
        .add(new Column(field: 'Currency', caption: 'Валюта', size: '100px'));
    columns.add(new Column(
        field: 'ContractorName', caption: 'Исполнитель', size: '200px'));

    var options = new GridOptions()
      ..name = 'worksGrid'
      ..columns = columns
      ..show = showOptions
      /*..url = '//cm-ylng-msk-01/cmas-backend/api/contract/1/works'*/
      ..url = 'http://localhost:5000/api/contract/1/works'
      ..method = 'GET';

    _worksGrid = new Grid(this._resourcesLoaderService, "#worksGrid", options);
  }

  void MaterialsGridInit() {
    var columns = new List<Column>();

    columns.add(
        new Column(field: 'Code', caption: 'Код', size: '100px', frozen: true));
    columns.add(new Column(
        field: 'Name',
        caption: 'Наименование материалов',
        size: '300px',
        frozen: true));

    columns.add(new Column(field: 'Unit', caption: 'Ед. изм.', size: '100px'));
    columns
        .add(new Column(field: 'Amount', caption: 'Количество', size: '100px'));
    columns
        .add(new Column(field: 'Currency', caption: 'Валюта', size: '100px'));
    columns.add(new Column(
        field: 'ObjectConstruction',
        caption: 'Объект строительства',
        size: '200px'));
    columns.add(new Column(field: 'Cost', caption: 'Стоимость', size: '100px'));
    columns.add(new Column(
        field: 'DeliveryDate',
        caption: 'Дата поставки',
        size: '150px',
        render: 'date'));

    var options = new GridOptions()
      ..name = 'materialsGrid'
      ..columns = columns
      //..url = ' //cm-ylng-msk-01/cmas-backend/api/contract/1/materials'
      ..url = 'http://localhost:5000/api/contract/1/materials'      
      ..method = 'GET';

    _materialsGrid =
        new Grid(this._resourcesLoaderService, "#materialsGrid", options);
  }

  @override
  void ngOnDestroy() {
    if (_materialsGrid != null) {
      _materialsGrid.Destroy();
    }

    if (_worksGrid != null) {
      _worksGrid.Destroy();
    }
  }
}
