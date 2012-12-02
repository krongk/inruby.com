#encoding: utf-8
module ApplicationHelper
  
  def is_mobile_agent?
    /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.match(request.user_agent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.match(request.user_agent[0..3])
  end

  def is_ie?
    request.env["HTTP_USER_AGENT"] =~ /MSIE.*6.*Windows NT/i
  end

  def title(page_title)
  	content_for(:title){ page_title}
  end
  def meta_keywords(meta_keywords)
  	content_for(:meta_keywords){ meta_keywords}
  end
  def meta_description(meta_description)
  	content_for(:meta_description){ meta_description}
  end

  #
  def current_class(name)
    if params.values.join(' ') =~ /\b#{name}/i
      return ' class = "current"'.html_safe
    end
    ''
  end
  #链接菜单导航，如：首页/关于我们
  #input: nav_bar [['首页', '/'], ['关于', '/about']]
  def nav_bar(bar_arr)
    strs = ['<div id="nav_bar">']
    bar_arr.each do |nav|
      strs << link_to(nav[0], nav[1], :class=> 'nav_bar_link')
      strs << " / "
    end
    strs << "</div>"
    content_for(:nav_bar){
      strs.join.html_safe
    }
  end
  
  #tags
  def project_tags
    $tags ||= []
    if $tags.blank?
      ProjectItem.find_each do |item|
        next if item.tags.blank?
        item.tags.split(',').map{|t| t.strip}.uniq.each do |t|
          next if $tags.include?(t)
          $tags << t
        end
      end
    end
    html = ["<h3>标签云</h3><div class='tags'>"]
    $tags.each do |t|
      html << %{<a href="/project_items/?tag=#{t}" target="_blank" class="size#{rand(5)}"><span class="color#{rand(5)}">#{t}</span></a>}
    end
    html << "</div>"
    html.join.html_safe
  end

  def truncate_content(content, count)
    strip_tags(content).to_s.gsub(/[ ]+|\s+|\t+|\n+/, ' ').truncate(count)
  end

  #get search result body html
  def get_search_result_body_html(record_arr)
    str_arr = []
    record_arr.each_with_index do |r, index|
      str_arr << %{<div class="search_item" id="search_item_#{index}">
        <h3 class="titbg"><span class="title_ico">&nbsp;</span>
        <a href="#{r.url}" target="_blank">#{r.title}</a>
        </h3>
        <a href="#{r.url}" target="_blank">#{r.url[0..79]}</a><br/>
        #{(r.summary).html_safe}
        </div>}
    end
    str_arr.join("\n")
  end
  #flash动画显示
  # eg: play_flash("flash/top_banner.swf")
  # or: play_flash asset_path("flash/top_banner.swf"), :width => '985', :height => '249'
  def play_flash(src, options = {:width=>'600', :height=>'400'})
    str = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' width='"+ options[:width] +"' height='"+ options[:height] +"' id='FlashID' accesskey='1' tabindex='1' title='omero'>
        <param name='movie' value='" + src + "' />
        <param name='quality' value='high' />
        <param name='wmode' value='transparent' />
        <param name='swfversion' value='9.0.45.0' />
        <param name='expressinstall' value='" + asset_path('Scripts/expressInstall.swf') + "' />
        <!--[if !IE]>-->
        <object type='application/x-shockwave-flash' data='" + src + "' width='"+  options[:width] +"' height='"+  options[:height] +"'>
          <!--<![endif]-->
          <param name='movie' value='" + src + "' />
          <param name='quality' value='high' />
          <param name='wmode' value='transparent' />
          <param name='swfversion' value='9.0.45.0' />
          <param name='expressinstall' value='"+ asset_path('Scripts/expressInstall.swf') + "' />
          <div>
            <h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
            <p><a href='http://www.adobe.com/go/getflashplayer'><img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='获取 Adobe Flash Player' width='112' height='33' /></a></p>
          </div>
          <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>"
    return str.html_safe
  end

  #item={:url => nil, :title => nil}
  def nice_tag_li(item)
    case rand(6)
    when 0
      %{<li style="color: #636563; font-family: rooney-web; font-style: italic; margin-top: 20px; margin-right: 10px; margin-bottom: 20px; margin-left: 10px; border-style: initial; border-color: initial; border-image: initial; font: inherit; vertical-align: baseline; display: inline-block; height: 15px; background-image: none; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: initial; border-width: 0px; padding: 0px;"><a class="webApp" style="border-style: initial; border-color: #deded6; border-image: initial; font: inherit; vertical-align: baseline; outline-width: 0px; outline-style: initial; outline-color: initial; color: #ffffff; text-decoration: none; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: #c1161c; border-top-left-radius: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; border-bottom-left-radius: 10px; -webkit-box-shadow: #999999 3px 3px 3px 2px; box-shadow: #999999 3px 3px 3px 2px; border-width: 0px; padding: 10px; margin: 0px;"  href="#{item[:url]}" target="_blank"><span><span>#{item[:title]}</span></span></a></li>}.html_safe
    when 1
      %{<li style="color: #636563; font-family: rooney-web; font-style: italic; margin-top: 20px; margin-right: 10px; margin-bottom: 20px; margin-left: 10px; border-style: initial; border-color: initial; border-image: initial; font: inherit; vertical-align: baseline; display: inline-block; height: 15px; background-image: none; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: initial; border-width: 0px; padding: 0px;"><a class="facebook" style="border-style: initial; border-color: #deded6; border-image: initial; font: inherit; vertical-align: baseline; outline-width: 0px; outline-style: initial; outline-color: initial; color: #ffffff; text-decoration: none; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: #3b5998; border-top-left-radius: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; border-bottom-left-radius: 10px; -webkit-box-shadow: #999999 3px 3px 3px 2px; box-shadow: #999999 3px 3px 3px 2px; border-width: 0px; padding: 10px; margin: 0px;"  href="#{item[:url]}" target="_blank"><span><span>#{item[:title]}</span></span></a></li>}.html_safe
    when 2
      %{<li style="color: #636563; font-family: rooney-web; font-style: italic; margin-top: 20px; margin-right: 10px; margin-bottom: 20px; margin-left: 10px; border-style: initial; border-color: initial; border-image: initial; font: inherit; vertical-align: baseline; display: inline-block; height: 15px; background-image: none; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: initial; border-width: 0px; padding: 0px;"><a class="crowdFunding" style="border-style: initial; border-color: #deded6; border-image: initial; font: inherit; vertical-align: baseline; outline-width: 0px; outline-style: initial; outline-color: initial; color: #ffffff; text-decoration: none; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: #92cb56; border-top-left-radius: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; border-bottom-left-radius: 10px; -webkit-box-shadow: #999999 3px 3px 3px 2px; box-shadow: #999999 3px 3px 3px 2px; border-width: 0px; padding: 10px; margin: 0px;"  href="#{item[:url]}" target="_blank"><span><span>#{item[:title]}</span></span></a></li>}.html_safe
    when 3
      %{<li style="color: #636563; font-family: rooney-web; font-style: italic; margin-top: 20px; margin-right: 10px; margin-bottom: 20px; margin-left: 10px; border-style: initial; border-color: initial; border-image: initial; font: inherit; vertical-align: baseline; display: inline-block; height: 15px; background-image: none; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: initial; border-width: 0px; padding: 0px;"><a class="ecommerce" style="border-style: initial; border-color: #deded6; border-image: initial; font: inherit; vertical-align: baseline; outline-width: 0px; outline-style: initial; outline-color: initial; color: #ffffff; text-decoration: none; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: #168aba; border-top-left-radius: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; border-bottom-left-radius: 10px; -webkit-box-shadow: #999999 3px 3px 3px 2px; box-shadow: #999999 3px 3px 3px 2px; border-width: 0px; padding: 10px; margin: 0px;"  href="#{item[:url]}" target="_blank"><span><span>#{item[:title]}</span></span></a></li>}.html_safe
    when 4
      %{<li style="color: #636563; font-family: rooney-web; font-style: italic; margin-top: 20px; margin-right: 10px; margin-bottom: 20px; margin-left: 10px; border-style: initial; border-color: initial; border-image: initial; font: inherit; vertical-align: baseline; display: inline-block; height: 15px; background-image: none; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: initial; border-width: 0px; padding: 0px;"><a class="rorConsulting" style="border-style: initial; border-color: #deded6; border-image: initial; font: inherit; vertical-align: baseline; outline-width: 0px; outline-style: initial; outline-color: initial; color: #ffffff; text-decoration: none; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: #f58220; border-top-left-radius: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; border-bottom-left-radius: 10px; -webkit-box-shadow: #999999 3px 3px 3px 2px; box-shadow: #999999 3px 3px 3px 2px; border-width: 0px; padding: 10px; margin: 0px;"  href="#{item[:url]}" target="_blank"><span><span>#{item[:title]}</span></span></a></li>}.html_safe
    else
      %{<li style="color: #636563; font-family: rooney-web; font-style: italic; margin-top: 20px; margin-right: 10px; margin-bottom: 20px; margin-left: 10px; border-style: initial; border-color: initial; border-image: initial; font: inherit; vertical-align: baseline; display: inline-block; height: 15px; background-image: none; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: initial; border-width: 0px; padding: 0px;"><a class="hireRor" style="border-style: initial; border-color: #deded6; border-image: initial; font: inherit; vertical-align: baseline; outline-width: 0px; outline-style: initial; outline-color: initial; color: #ffffff; text-decoration: none; background-image: none; background-attachment: scroll; background-origin: initial; background-clip: initial; background-color: #292929; border-top-left-radius: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; border-bottom-left-radius: 10px; -webkit-box-shadow: #999999 3px 3px 3px 2px; box-shadow: #999999 3px 3px 3px 2px; background-position: 0px 0px; background-repeat: repeat repeat; border-width: 0px; padding: 10px; margin: 0px;" href="#{item[:url]}" target="_blank"><span><span>#{item[:title]}</span></span></a></li>}.html_safe
    end
  end

end
