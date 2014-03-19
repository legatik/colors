$(document).ready () ->
  
  console.log "globalJS"
  
  jQuery.browser = {};
  jQuery.browser.mozilla = /mozilla/.test(navigator.userAgent.toLowerCase()) && !/webkit/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.webkit = /webkit/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.opera = /opera/.test(navigator.userAgent.toLowerCase());
  jQuery.browser.msie = /msie/.test(navigator.userAgent.toLowerCase());
  
  window.nav = {
    face:{
      title : "Для лица"
      tip : [
        {
          title : "ОЧИЩЕНИЕ"
          key : "face-ochishenie"
          podtip: [
            {
              title : "Для снятия макияжа"
              key : "face-ochishenie1"
            }
            {
              title : "Гидрофильные масла"
              key : "face-ochishenie2"
            }
            {
              title : "Гели для умывания"
              key : "face-ochishenie3"
            }
            {
              title : "Пенки для умывания"
              key : "face-ochishenie4"
            }
            {
              title : "Кремы, пудры для умывания"
              key : "face-ochishenie5"
            }
          ]
        }
      
        {
          title : "ТОНИЗИРОВАНИЕ"
          key : "face-tonizir"
          podtip: [
            {
              title : "Бустеры"
              key : "face-tonizir1"
            }
            {
              title : "Тонеры, стартеры"
              key : "face-tonizir2"
            }
            {
              title : "Мисты (спреи)"
              key : "face-tonizir3"
            }
            {
              title : "Тампоны-патчи"
              key : "face-tonizir4"
            }
          ]
        }
   
        {
          title : "ОСНОВНОЙ УХОД"
          key : "face-osnov-uhod"
          podtip: [
            {
              title : "Ампулы"
              key : "face-osnov-uhod1"
            }
            {
              title : "Сыворотки и эссенции"
              key : "face-osnov-uhod2"
            }
            {
              title : "Лосьоны и эмульсии"
              key : "face-osnov-uhod3"
            }
            {
              title : "Гели"
              key : "face-osnov-uhod4"
            }
          ]
        }
      

        {
          title : "СПЕЦИАЛЬНЫЙ УХОД"
          key : "face-spec-uhod"
          podtip: [
            {
              title : "Бальзамы и концентраты"
              key : "face-spec-uhod1"
            }
            {
              title : "Точенчные средства"
              key : "face-spec-uhod2"
            }
            {
              title : "Масла"
              key : "face-spec-uhod3"
            }
            {
              title : "Массажные средства"
              key : "face-spec-uhod4"
            }
          ]
        }

        {
          title : "СОЛНЦЕЗАЩИТНЫЕ СРЕДСТВА"
          key : "face-sonlce-zach"
          podtip: []
        }

        {
          title : "ОТШЕЛУШИВАНИЕ"
          key : "face-otchelush"
          podtip: [
            {
              title : "Скрабы и гаммажи"
              key : "face-otchelush1"
            }
            {
              title : "Пилинги"
              key : "face-otchelush2"
            }
          ]
        }


        {
          title : "МАСКИ"
          key : "face-mask"
          podtip: [
            {
              title : "Ночные маски"
              key : "face-mask1"
            }
            {
              title : "Маски: посты, кремы, пенки"
              key : "face-mask2"
            }
            {
              title : "Тканевые, листовые маски"
              key : "face-mask3"
            }
            {
              title : "Точенчные маски-патчи"
              key : "face-mask4"
            }
          ]
        }
      ]
      dop : [
        {
          title : "Тип кожи"
          key   : "kozha"
          list  : [
            {
              title : "Для всех типов кожи"
              key   : "face-kozh-all"
            }
            {
              title : "Нормальная"
              key   : "face-kozh-norm"
            }
            {
              title : "Жирная/комбинированная"
              key   : "face-kozh-zhir"
            }
            {
              title : "Сухая/очень сухая"
              key   : "face-kozh-suh"
            }
            {
              title : "Проблемная"
              key   : "face-kozh-prob"
            }
            {
              title : "Чувствительная"
              key   : "face-kozh-chuv"
            } 
          ]
        }
        {
          title : "Несовершенства"
          key   : "nesovershenstva"
          list  : [
            {
              title : "Нет несовершенств"
              key   : "face-nes-net"
            }
            {
              title : "Лечение акне и постакне"
              key   : "face-nes-akne"
            }
            {
              title : "Против черных точек"
              key   : "face-nes-cher"
            }
            {
              title : "Сужение пор"
              key   : "face-nes-suzh"
            }
            {
              title : "Отбеливание"
              key   : "face-nes-otb"
            }
            {
              title : "Разглаживание морщин"
              key   : "face-nes-morch"
            } 
            {
              title : "Лифтинг"
              key   : "face-nes-lif"
            } 
            {
              title : "Сухость, шелушение"
              key   : "face-nes-suh"
            } 
            {
              title : "Усталость, тусклый цвет лица"
              key   : "face-nes-ust"
            } 
          ]
        }
      ]
    }

    body:{
      title: "Для тела"
      tip:[
        {
          title : "УХОД ЗА ТЕЛОМ"
          key : "body-body"
          podtip: [
            {
              title : "Для ванны и душа"
              key : "body-body1"
            }
            {
              title : "Лосьены, кремы и бальзамы"
              key : "body-body2"
            }
            {
              title : "Спреи"
              key : "body-body3"
            }
            {
              title : "Масла"
              key : "body-body4"
            }
            {
              title : "Массажные средства"
              key : "body-body5"
            }
            {
              title : "Скрабы"
              key : "body-body6"
            }
          ]
        }
        
        
        {
          title : "УХОД ЗА РУКАМИ"
          key : "body-hend"
          podtip: [
            {
              title : "Кремы и лосьоны"
              key : "body-hend1"
            }
            {
              title : "Маски и скрабы"
              key : "body-hend2"
            }
            {
              title : "Уход за ногтями"
              key : "body-hend3"
            }
          ]
        }
        
        
        {
          title : "УХОД ЗА НОГАМИ"
          key : "body-footer"
          podtip: [
            {
              title : "Скрабы и пилинги"
              key : "body-footer1"
            }
            {
              title : "Маски и патчи"
              key : "body-footer2"
            }
            {
              title : "Лосьоны, кремы, спреи"
              key : "body-footer3"
            }
            {
              title : "Дезодорирующие средства"
              key : "body-footer4"
            }
          ]
        }
        
        {
          title : "ДЛЯ СТРОЙНОГО СИЛУЭТА"
          key : "body-stroin"
          podtip: [
            {
              title : "Гели, кремы и скрабы"
              key : "body-stroin1"
            }
            {
              title : "Маски и патчи"
              key : "body-stroin2"
            }
          ]
        }
        
        {
          title : "ЭПИЛЯЦИЯ, ДЕПИЛЯЦИЯ"
          key : "body-epil"
          podtip: []
        }
        
        {
          title : "ПАРФЮМИРОВАННЫЕ И 
ДЕЗОДОРИРУЮЩИЕ СРЕДСТВА"
          key : "body-epil"
          podtip: []
        }
        
        
        {
          title : "СОЛНЦЕЗАЩИТНЫЕ СРЕДСТВА"
          key : "body-epil"
          podtip: []
        }
      ]
      
      
      dop : [
        {
          title : "Несовершенства"
          key : "nesovershenstva"
          list : [
            {
              title : "Нет несовершенств"
              key   : "body-nes-net"
            }
            {
              title : "Против сухости кожи"
              key   : "body-nes-suh"
            }
            {
              title : "Против усталости"
              key   : "body-nes-ust"
            }
            {
              title : "Против морщин и потери упругости"
              key   : "body-nes-morch"
            }
            {
              title : "Отбеливающие средства"
              key   : "body-nes-otb"
            }
          ]
        }
      ]
    }

  }
  
  
