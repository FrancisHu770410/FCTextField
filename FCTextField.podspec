Pod::Spec.new do |s|
	s.name	= "FCTextField"
	s.version = “1.0.1”
	s.summary = "一個可以輸出台灣電話號碼格式的TextField"
	s.description = <<-DESC
			 不管輸入什麼格式文字或進行任何刪除操作都會輸出台灣電話號碼格式
			DESC
	s.homepage = "https://github.com/FrancisHu770410/FCTextField"
	s.license = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
	s.author = { "FrancisHu770410" => "FrancisHu770410@gmail.com" }
	s.source = { :git => "https://github.com/FrancisHu770410/FCTextField.git", :tag => s.version.to_s }

	s.platform = :ios, ‘8.0’
	s.requires_arc = true

	s.source_files = 'FCTextField/*'
	s.frameworks = 'Foundation', 'UIKit'


end
