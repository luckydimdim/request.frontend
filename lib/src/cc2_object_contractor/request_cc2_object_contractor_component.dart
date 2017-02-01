import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:intl/intl.dart';

import 'package:resources_loader/resources_loader.dart';

@Component(
    selector: 'request-cc2',
    templateUrl: 'request_cc2_object_contractor_component.html')
class RequestCc2ObjectContractorComponent implements AfterViewInit, OnInit {
  static const String route_name = 'RequestCc2ObjectContractor';
  static const String route_path = 'cc-2/:objectName/:contractorName';
  static const Route route = const Route(
      path: RequestCc2ObjectContractorComponent.route_path,
      component: RequestCc2ObjectContractorComponent,
      name: RequestCc2ObjectContractorComponent.route_name);

  final Router _router;
  final ResourcesLoaderService _resourcesLoaderService;
  final RouteParams _routeParams;

  RequestCc2ObjectContractorComponent(
      this._router, this._resourcesLoaderService, this._routeParams) {}

  @override
  ngOnInit() {
    String objectName = _routeParams.get('objectName');
    String contractorName = _routeParams.get('contractorName');
  }

  @override
  void ngAfterViewInit() {
    // TODO: Продумать показ/скрытие меню
    document.body.classes.remove('mobile-open');
    document.body.classes.remove('aside-menu-open');

    _resourcesLoaderService.loadScript(
        'vendor/moment/min/', 'moment.min.js', false);

    _resourcesLoaderService.loadScript(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.js', false);

    _resourcesLoaderService.loadStyle(
        'vendor/bootstrap-daterangepicker/', 'daterangepicker.css');

    var printButtonList = querySelectorAll('[print-cc2]') as List<ButtonElement>;
    printButtonList.forEach((ButtonElement button) {
      button.onClick.listen((MouseEvent e) {
        _router.parent.parent.navigateByUrl('/cc2-print');
      });
    });

    final formatter = new NumberFormat("#.##", "en_US");

    var table = querySelector('[calculation-table]') as TableElement;
    table.rows.forEach((TableRowElement row) {
      var priceCell = row.querySelector('[data-unit-price]') as TableCellElement;
      var quantityInput = row.querySelector('[data-unit-quantity]') as InputElement;
      var totalCell = row.querySelector('[data-total]') as TableCellElement;

      if (totalCell != null) {
        quantityInput.onChange.listen((Event e) {
          var newQuantity = e.currentTarget as InputElement;

          totalCell.innerHtml = '${formatter.format(int.parse(priceCell.innerHtml, onError:(_) => 0) * int.parse(newQuantity.value, onError: (_) => 0))} р.';
        });
      }
    });
  }
}