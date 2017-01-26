import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:resources_loader/resources_loader.dart';
import 'package:grid/grid.dart';

@Component(selector: 'request-settings', templateUrl: 'request_settings_component.html')
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
    _resourcesLoaderService.loadScript('assets/js/', 'app.js', false);

    _resourcesLoaderService.loadScript(
        'vendor/moment/min/', 'moment.min.js', false);

    _resourcesLoaderService.loadScript(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoaderService.loadStyle(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.css');

    _resourcesLoaderService.loadScript(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoaderService.loadScript(
        'packages/request/src/settings/', 'init-date-range.js', false);

    document.body.classes.add('mobile-open');
    document.body.classes.add('aside-menu-open');

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

    WorksGridInit();
    //MaterialsGridInit(); // FIXME: перерисовывать таблицу при активации таба
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
      ..url = ' //cm-ylng-msk-01/cmas-backend/api/contract/1/works'
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
      ..url = ' //cm-ylng-msk-01/cmas-backend/api/contract/1/materials'
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
