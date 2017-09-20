package com.helix.data
{
	public class HelixItem
	{
		public var target:String;
		public var urlThumb:String;
		public var urlDetail:String;

		public function fromXml(xml:XML):void{
			target=xml.target;
			urlThumb=xml.thumb;
			urlDetail=xml.detail;
		}
	}
}