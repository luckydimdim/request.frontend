import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:js/js_util.dart';
import 'package:js/js.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:grid/JsObjectConverter.dart';
import 'package:grid/jq_grid.dart';
import 'package:daterangepicker/daterangepicker.dart' as picker;

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


  RequestSettingsComponent(this._router, this._resourcesLoaderService) {}

  // import 'dart:html';
  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item active">Параметры</li>
    ''';
  }

  @override
  void ngOnInit() {
    breadcrumbInit();


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
    MaterialsGridInit();

    $('a[data-toggle="tab"]').on('shown.bs.tab', allowInterop(render));
  }

  void DateRangeInit() {
    var options = new picker.DateRangePickerOptions();

    new picker.DateRangePicker(
        this._resourcesLoaderService, '#request-date-range-picker', options);
  }

  void render(dynamic e) {
    var target = getProperty(e, 'target');
    var hash = getProperty(target, 'hash');

    if (hash == '#works') {
      $("#worksGrid").jqxTreeGrid('render');
    }
    else if (hash == '#materials') {
      $("#materialsGrid").jqxTreeGrid('render');
    }
  }

  Future WorksGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование этапа/работы'
      ..pinned = true);

    columns.add(new Column()
      ..dataField = 'Unit'
      ..text = 'Ед. изм.');
    columns.add(new Column()
      ..dataField = 'Amount'
      ..text = 'Объем');
    columns.add(new Column()
      ..dataField = 'Cost'
      ..text = 'Стоимость');
    columns.add(new Column()
      ..dataField = 'UnitCost'
      ..text = 'Стоимость ед измерения');
    columns.add(new Column()
      ..dataField = 'Currency'
      ..text = 'Валюта');
    columns.add(new Column()
      ..dataField = 'ContractorName'
      ..text = 'Исполнитель');

    var hierarchy = new Hierarchy()
      ..root = 'children';

    var source = new SourceOptions()
      ..url = 'packages/request/src/settings/works.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = true
      ..source = source
      ..height = null
      ..editable = false
      ..columns = columns;

    var _worksGrid = new jqGrid(this._resourcesLoaderService, "#worksGrid",
        JsObjectConverter.convert(options));
    await _worksGrid.Init();
  }

  Future MaterialsGridInit() async {
    var columns = new List<Column>();

    columns.add(new Column()
      ..dataField = 'Name'
      ..text = 'Наименование материалов'
      ..pinned = true);

    columns.add(new Column()
      ..dataField = 'Unit'
      ..text = 'Ед. изм.');
    columns.add(new Column()
      ..dataField = 'Amount'
      ..text = 'Количество');
    columns.add(new Column()
      ..dataField = 'Currency'
      ..text = 'Валюта');
    columns.add(new Column()
      ..dataField = 'ObjectConstruction'
      ..text = 'Объект строительства');
    columns.add(new Column()
      ..dataField = 'Cost'
      ..text = 'Стоимость');
    columns.add(new Column()
      ..dataField = 'UnitCost'
      ..text = 'Стоимость ед измерения');
    columns.add(new Column()
      ..dataField = 'DeliveryDate'
      ..text = 'Дата поставки');

    var hierarchy = new Hierarchy()
      ..root = 'children';

    var source = new SourceOptions()
      ..url = 'packages/request/src/settings/materials.json'
      ..id = 'recid'
      ..hierarchy = hierarchy
      ..dataType = 'json';

    var options = new GridOptions()
      ..checkboxes = true
      ..source = source
      ..editable = false
      ..height = null
      ..columns = columns;

    var _worksGrid = new jqGrid(this._resourcesLoaderService, "#materialsGrid",
        JsObjectConverter.convert(options));

    await _worksGrid.Init();
  }

  @override
  void ngOnDestroy() {

  }
}
