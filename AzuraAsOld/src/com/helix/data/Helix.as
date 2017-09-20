package com.helix.data
{
	import mx.events.ItemClickEvent;
	
	public class Helix
	{
		public var gallery:Gallery;
		public var id:String;
		public var urlTitle:String;
		public var isLeaf:Boolean;
		public var back:Helix;
		public var itemList:Vector.<HelixItem>=new Vector.<HelixItem>();
		
		public function Helix(gallery:Gallery)
		{
			this.gallery=gallery;
		}
		
		public function fromXml(xml:XML):void{
			id=xml.@id;
			isLeaf=xml.@isLeaf=="true";
			urlTitle=xml.title;
			var list:XMLList=new XMLList(xml.item);
			for each(var ix:XML in list){
				var hi:HelixItem=new HelixItem();
				hi.fromXml(ix);
				itemList.push(hi);
			}
		}
	}
}